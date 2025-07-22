在创建虚拟机开发环境时的最佳实践：
1.    使用桥接网络模式，这样虚拟机可以直接使用主机的网络连接。
1.1   虚拟机也使用静态IP ( 假设 192.168.0.100 ) ，这样可以避免每次连接虚拟机时，都要适配虚拟机IP。      
      在虚拟机设置中，使用“桥接适配器”，这样虚拟机可以直接使用主机的网络连接。
      我们使用临时设置静态IP地址的方法，而不是永久修改虚拟机的网络配置文件。（风险低，重启就恢复）
      虚拟机启动后，执行一次:
      source ${BASH_DIR}/app/virtual_machine/set_static_ip_in_vm.sh  
1.2   主机使用静态IP （ 假设 192.168.0.102 ） ，这样虚拟机可以通过主机的IP地址访问外部网络。
      方法一 : 手动UI操作 【推荐】
      Ctrl + R : 在弹出的运行窗口输入 ncpa.cpl 并回车，打开 网络连接 设置
      然后选择 当前 windows 主机使用的网卡，右键，选择属性，双击 internet 协议版本(TCP/IPv4)
      选择使用下面的IP地址
      192.168.0.102 
      255.255.255.0 
      192.168.0.1

      方法二 : 命令行操作
      netsh interface ipv4 show interfaces
      netsh interface ip set address name="Ethernet" static 192.168.0.102 255.255.255.0 192.168.0.1
      netsh interface ip set address name="以太网 3"  static 192.168.0.102 255.255.255.0 192.168.0.1

      方法三 : 使用脚本：
      call %myPcToolsPath%\common\tools_network.bat setStaticIp "Ethernet" "192.168.0.102"  "255.255.255.0" "192.168.0.1"

2. 设置虚拟机自动登陆，避免每次都要输入用户名和密码。
   source ${BASH_DIR}/app/virtual_machine/enable_vm_auto_login.sh
   注： 此脚本基于 ubuntu-14.04-desktop-amd64.iso 已经成功验证过

3. 使用共享文件夹功能，这样可以方便地在虚拟机和主机之间传输文件。
4. 安装增强功能，这样可以提高虚拟机的性能和用户体验。