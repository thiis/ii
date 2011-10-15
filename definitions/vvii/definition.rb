Veewee::Session.declare({
    :cpu_count => '1',  :memory_size=> '384', 
    :host_only_nic => 'vboxnet0',
    :bridge_nic => 'eth0',
    :disk_size => '10140', :disk_format => 'VDI', :hostiocache => 'off',
    :os_type_id => 'Ubuntu',
    :iso_file => "ubuntu-10.04.3-server-i386.iso",
    :iso_src => "http://releases.ubuntu.com/10.04.3/ubuntu-10.04.3-server-i386.iso",
    :iso_md5 => "388104f6225ae676ceab0ba4bd7b5784",
    :iso_download_timeout => "1000",
    :boot_wait => "10",
    :boot_cmd_sequence => [
      '<Esc><Esc><Enter>',
      '/install/vmlinuz noapic preseed/url=http://%IP%:%PORT%/preseed.cfg ',
      'debian-installer=en_NZ auto locale=en_NZ kbd-chooser/method=us ',
      'hostname=%NAME% ',
#      'fb=false ',
      'debconf/frontend=noninteractive ',
      'vga16fb.modeset=0 ',
      'interface=eth0 ',
      'console-setup/ask_detect=false console-setup/modelcode=pc105 console-setup/layoutcode=us ',
      'dbg/flags=all-x DEBCONF_DEBUG=5 DEBCONF_INTERFACE=noninteractive ',
      'initrd=/install/initrd.gz -- <Enter>'
    ],
    :kickstart_port => "7122", :kickstart_timeout => "10000", :kickstart_file => "preseed.cfg",
    :ssh_login_timeout => "10000", :ssh_user => "vagrant", :ssh_password => "vagrant", :ssh_key => "",
    :ssh_host_port => "7222", :ssh_guest_port => "22",
    :sudo_cmd => "echo '%p'|sudo -S bash '%f'",
    :shutdown_cmd => "shutdown -P now",
    :postinstall_files => [
#      "vvii.sh",
      "vagrant.sh"
    ],
    :postinstall_timeout => "10000"
})
