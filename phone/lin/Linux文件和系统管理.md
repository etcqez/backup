---
title: Linux文件和系统管理
date: 2022-10-04 13:54:15
tags:
---
### 用户管理
```bash
cp -r   # -r: recorsive递归
more    # 空格翻页，回车换行
grep 过滤词 文件名 
mkdir -pv /a/{b/{d,e},c}    # -p: 创建父文件夹 -v:显示过程
cp -rf # f: 不提示（删不可写文件） r: recorsive递归（删文件夹）
tail /etc/shadow    # 1.用户名  2.密码加密值    3.最后一次修改时间, 过了多少天  4.最小间隔  5.最大时间间隔, 密码有效期  6,警告时间  7，不活动时间（用户不登录系统，超过天数，禁用） 8.失效时间（到期后就不能用了）  9.保留
cat /etc/group  1.组名  2.组密码    3.组成员
useradd user01 -u 1500 -d  # -u: uid    -d: 家目录
userdel -r user01   # -r: remove家目录
usermod -s /sbin/nologin user01 # 改shell
groupadd group01 -g 2000    # -g: 指定组id
usermod user01 -g group02   # -g: 修改用户基本组
usermod user01 -g group02   # -G: 修改用户附加组
groupadd -g 1511 group03    # 修改组id
```

### 用户的权限
```bash
chmod [u,g,o,a][-,+,=][r,w,x]
#eg:
    chmod u+rwx a.sh
    chmod g+rwx b.sh
    chmod o-rwx c.sh
    chmod a=rwx d.sh
    chmod a=--- e.sh    # 没有权限
    chmod u= h.sh   # 没有权限
# chown
chown usero1.group01 a.txt    # 更改所有者，所有组
chown usero1 a.txt  # 更改所有者
chown .group01 a.txt    # 更改所有组
chmod -R 777 dir01/ # -R: 递归修改文件夹内所有文件权限

# setfacl(set file access control list) 设置文件访间控制列表
setfacl -m [u,g,o]:[用户名，组名]:[rwx-] a.txt  # 修改用户，组的权限
eg: setfacl -m u:jack:---    # 设置用户jack的权限为空
    setfacl -m g:computer:rwx   # 设置组computer的权限为rwx
setfacl -m [u,g,0]::[rwx-] a.txt    # 同chmod
#eg: 
    setfacl -m u::rwx a.txt == chmod u=rwx a.txt
    setfacl -m o::--- a.txt == chmod o=--- a.txt
gitfacl a.txt
setfacl -x u:alice a.txt    # 删除alice的权限
setfacl -b a.txt    # 删除所有权限
```
#### 重点
watch -n1能够反复查看一条命令的动态变化，以下是ls -l搭配chown，实现动态查看文件权限变化的方法
1. watch -n1 'ls -l a.txt'
2. chmod u=rwx a.txt
文件执行需要可读可执行条件，单单是执行是不够的
#### 特殊权限
```bash
# 特殊位suid，使调用文件的用户，监时具有属主的能力
chmod u+s /usr/bin/cat
# 文件属性
chattr [-,+][i,a] 1.txt   # i: 不能删除，不能修改文件名、文件内容，不能移动位置 a: 只能>>追加
lsattr 1.txt    # 查看属性
```
### 进程管理
```bash
ps aux | head -2    # USER: 运行进程的用户  PID: 进程ID %CPU：CPU占用率 %MEM: 内存占用率 VSZ：占用虚拟内存   RSS：占用实际内存   TTY：运行的终端 STAT：运行状态  START：进程的启动时间   TIME：进程占用CPU的总时间   COMMAND：进程文件，进程名
ps aux --sort -%cpu # 按照cpu占用降序
ps aux --sort %cpu # 按照cpu占用升序
ps -ef  # 查看进程的父子关系
ps auo user,pid,%mem,%cpu,start,time | head -3  # 自定义显示列表
#top前5行
    %Cpu(s): CPU使用占比
        us: 用户
        sy: 系统
        ni：优先级
        id：空闲
        wa: 等待
        hi：硬件
        si：软件
        st：虚拟机
   #top快捷键
       h: 显示帮助
       z： 彩色
       <>: 翻页
       P: CPU降序
       M：MEM降序
       k: kill进程
top -d 3 -p 1   # -d: 每3秒刷新 -p: PID
eg: 查看某个程序
    ps aux | grep vim
    top -d 2 -p vim的PID
kill -l # 查看信号列表
kill -9 # 杀死 zombie时用
kill -15    # 退出 多数情况用
# nice赿低优先级赿高，可以设置的值为-20~19，pr是系统优先级，不能修改，自己设置的优先级需要加20进入系统优先级，以此不影响系统的正常运行
ps axo pid,command,nice --sort=-nice    # 查看优先级
nice -n -5 sleep 3000   # 调整优先级
renice -20 火狐ID   # 重设火狐优先级
ps axo pid,command,nice | grep firefox  # 查看火狐的优先级
top -d 1 -p 火狐PID # 查看火狐的优先级和系统优先级，此时火狐的优先级是-20，而系统优先级为0
jobs    # 查看后台进程，+代表最新进程
fg 进程序号 # 前台运行
bg 进程序号 # 后台运行
kill %4 # kill4号后台进程
```
####重点
```bash
|tee a.txt  # 将前面输出的内容保存一份
|xargs rm -rvf  # 删除
```
### lvm(logic volume manager)
术语
1. PV: 物理卷(Physical volume)
2. VG: 卷组(Volume Group)
3. LV: 逻辑卷(Logical volume)
```bash
pvcreate /dev/sdx   # 创建物理卷
vgcreate 名字/vg1 /dev/sdx  # 创建卷组
lvcreate -L 50G -n 名字/lv1 vg1 # 创建逻辑卷
mkfs.ext4 /dev/vg1/lv1
mkdir /mnt/lv1
mount /dev/vg1/lv1 /mnt/lv1
```
扩大卷组
```bash
pvcreate /dev/sdx
pvs # 查询物理卷
vgextend vg1 /dev/sdx
vgs # 查询卷组
```
扩大逻辑卷
```bash
lvextend -L +50G /dev/vg1/lv1
resize2fs /dev/vg1/lv1
```
### 文件系统（超市储物柜）
名词
1. inode(index node)，超市储物柜的小票
    1. 记录文件的属性（文件的元数据metadata)    元数据：文件的属性，大小，权限，属主，属组，链接数，块的数量，块的编号
    2. 一个文件中用一个inode，同时记录此文件数所在的block number
    3. inode的大小为128bytes
2.block
    1. 存储实际数据
    2. 实际存储文件的内容，若文件较大，会占用多个block
    3. block大小默认为4K
**结论：inode决定了文件系统中文件的数量**
```bash
df -i   # 查看inode已用数量和可用数量
```
**结论：磁盘空间的限制根所inode和block两方面**
#### 创建RAID
'mdadm -C /dev/md0 -l5-n3-x1 /dev/sd{d,e,f,g}'
    1.-C 创建RAID
    2./dev/md0 第一个RAID设备
    3.-l5 RAID5
    4.-n RAID成员的数量
    5.-x 热备磁盘数量
查看`mdadm -D /dev/md0`
#### 查找和压缩
```bash
find /etc -iname HOSTS # iname：忽略大小写查找
find /etc -size [-,+]5M  # 查找大于/小于5M
eg: find / -size +100M  # 查找/大于100M的文件
find /dev -type b   # 查找块设备
find -perm 714  # 按权限
find / -size +100M -ls  # 按长格式显示
find / -perm 714 -delete
find /etc -name ifcfg* -ok cp -rvf {} /tmp \;
```
