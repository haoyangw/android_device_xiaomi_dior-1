# Copyright (c) 2009-2012,2014 The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

import init.qcom.usb.rc
import init.target.rc

on early-init
    mount debugfs debugfs /sys/kernel/debug

on init
    # Set permissions for persist partition
    mkdir /persist 0771 system system
    # See storage config details at http://source.android.com/tech/storage/
    mkdir /mnt/shell/emulated 0700 shell shell
    mkdir /storage/emulated 0555 root root
    mkdir /storage/emulated/legacy 0555 root root
    mkdir /mnt/media_rw/sdcard1 0700 media_rw media_rw
    mkdir /mnt/media_rw/usbotg 0700 media_rw media_rw
    mkdir /mnt/media_rw/uicc0 0700 media_rw media_rw
    mkdir /mnt/media_rw/uicc1 0700 media_rw media_rw
    mkdir /storage/sdcard1 0700 root root
    mkdir /storage/uicc0 0700 root root
    mkdir /storage/usbotg 0700 root root

    export EXTERNAL_STORAGE /storage/emulated/legacy
    export SECONDARY_STORAGE /storage/sdcard1
    export EMULATED_STORAGE_SOURCE /mnt/shell/emulated
    export EMULATED_STORAGE_TARGET /storage/emulated

    # Support legacy paths
    symlink /storage/emulated/legacy /sdcard
    symlink /storage/emulated/legacy /mnt/sdcard
    symlink /storage/emulated/legacy /storage/sdcard0

on early-boot
    # set RLIMIT_MEMLOCK to 64MB
    setrlimit 8 67108864 67108864
    # Allow subsystem (modem etc) debugging
    write /sys/module/subsystem_restart/parameters/enable_debug ${persist.sys.ssr.enable_debug}
    write /sys/kernel/boot_adsp/boot 1

on boot
    chown bluetooth bluetooth /sys/module/bluetooth_power/parameters/power
    chown bluetooth bluetooth /sys/class/rfkill/rfkill0/type
    chown bluetooth bluetooth /sys/class/rfkill/rfkill0/state
    chown bluetooth bluetooth /proc/bluetooth/sleep/proto
    chown bluetooth bluetooth /sys/module/hci_uart/parameters/ath_lpm
    chown bluetooth bluetooth /sys/module/hci_uart/parameters/ath_btwrite
    chown system system /sys/module/sco/parameters/disable_esco
    chown bluetooth bluetooth /sys/module/hci_smd/parameters/hcismd_set
    chmod 0660 /sys/module/bluetooth_power/parameters/power
    chmod 0660 /sys/module/hci_smd/parameters/hcismd_set
    chmod 0660 /sys/class/rfkill/rfkill0/state
    chmod 0660 /proc/bluetooth/sleep/proto
    chown bluetooth bluetooth /dev/ttyHS0
    chmod 0660 /sys/module/hci_uart/parameters/ath_lpm
    chmod 0660 /sys/module/hci_uart/parameters/ath_btwrite
    chmod 0660 /dev/ttyHS0
    chown bluetooth bluetooth /sys/devices/platform/msm_serial_hs.0/clock
    chmod 0660 /sys/devices/platform/msm_serial_hs.0/clock

    chmod 0660 /dev/ttyHS2
    chown bluetooth bluetooth /dev/ttyHS2

    #Create QMUX deamon socket area
    mkdir /dev/socket/qmux_radio 0770 radio radio
    chmod 2770 /dev/socket/qmux_radio
    mkdir /dev/socket/qmux_audio 0770 media audio
    chmod 2770 /dev/socket/qmux_audio
    mkdir /dev/socket/qmux_bluetooth 0770 bluetooth bluetooth
    chmod 2770 /dev/socket/qmux_bluetooth
    mkdir /dev/socket/qmux_gps 0770 gps gps
    chmod 2770 /dev/socket/qmux_gps

    setprop wifi.interface wlan0

#   Define TCP buffer sizes for various networks
#   ReadMin, ReadInitial, ReadMax, WriteMin, WriteInitial, WriteMax,
    setprop net.tcp.buffersize.wifi    524288,2097152,4194304,262144,524288,1048576


    setprop ro.telephony.call_ring.multiple false

    #Set SUID bit for usbhub
    chmod 4755 /system/bin/usbhub
    chmod 755 /system/bin/usbhub_init

    #Remove SUID bit for iproute2 ip tool
    chmod 0755 /system/bin/ip


    chmod 0444 /sys/devices/platform/msm_hsusb/gadget/usb_state

    #For bridgemgr daemon to inform the USB driver of the correct transport
    chown radio radio /sys/class/android_usb/f_rmnet_smd_sdio/transport

    # For setting tcp delayed ack
    chown system system /sys/kernel/ipv4/tcp_delack_seg
    chown system system /sys/kernel/ipv4/tcp_use_userconfig

#   Define TCP buffer sizes for various networks
#   ReadMin, ReadInitial, ReadMax, WriteMin, WriteInitial, WriteMax,
    setprop net.tcp.buffersize.default 4096,87380,110208,4096,16384,110208
    setprop net.tcp.buffersize.lte     524288,1048576,2097152,262144,524288,1048576
    setprop net.tcp.buffersize.umts    4094,87380,110208,4096,16384,110208
    setprop net.tcp.buffersize.hspa    4094,87380,1220608,4096,16384,1220608
    setprop net.tcp.buffersize.hsupa   4094,87380,1220608,4096,16384,1220608
    setprop net.tcp.buffersize.hsdpa   4094,87380,1220608,4096,16384,1220608
    setprop net.tcp.buffersize.hspap   4094,87380,1220608,4096,16384,1220608
    setprop net.tcp.buffersize.edge    4093,26280,35040,4096,16384,35040
    setprop net.tcp.buffersize.gprs    4092,8760,11680,4096,8760,11680
    setprop net.tcp.buffersize.evdo    4094,87380,262144,4096,16384,262144

# Define TCP delayed ack settings for WiFi & LTE
    setprop net.tcp.delack.default     1
    setprop net.tcp.delack.wifi        20
    setprop net.tcp.delack.lte         8
    setprop net.tcp.usercfg.default    0
    setprop net.tcp.usercfg.wifi       1
    setprop net.tcp.usercfg.lte        1

#   Assign TCP buffer thresholds to be ceiling value of technology maximums
#   Increased technology maximums should be reflected here.
    write /proc/sys/net/core/rmem_max  2097152
    write /proc/sys/net/core/wmem_max  2097152

    #To allow interfaces to get v6 address when tethering is enabled
    write /proc/sys/net/ipv6/conf/rmnet0/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet1/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet2/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet3/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet4/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet5/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet6/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet7/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_sdio0/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_sdio1/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_sdio2/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_sdio3/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_sdio4/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_sdio5/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_sdio6/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_sdio7/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_usb0/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_usb1/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_usb2/accept_ra 2
    write /proc/sys/net/ipv6/conf/rmnet_usb3/accept_ra 2

    # To prevent out of order acknowledgements from making
    # connection tracking to treat them as not belonging to
    # the connection they belong to.
    # Otherwise, a weird issue happens in which some long
    # connections on high-throughput links get dropped when
    # an ack packet comes out of order
    write /proc/sys/net/netfilter/nf_conntrack_tcp_be_liberal 1

    # NFC local data and nfcee xml storage
    mkdir /data/nfc 0770 nfc nfc
    mkdir /data/nfc/param 0770 nfc nfc

    # Enable ssr and modem ramdump
    setprop persist.sys.ssr.restart_level 3
    setprop persist.radio.ramdump_sdcard 1

# msm specific files that need to be created on /data
on post-fs-data
    # we will remap this as /mnt/sdcard with the sdcard fuse tool
    mkdir /data/media 0770 media_rw media_rw
    chown media_rw media_rw /data/media

    mkdir /data/misc/bluetooth 0770 bluetooth bluetooth

    # Create the directories used by the Wireless subsystem
    mkdir /data/misc/wifi 0770 wifi wifi
    mkdir /data/misc/wifi/sockets 0770 wifi wifi
    mkdir /data/misc/wifi/wpa_supplicant 0770 wifi wifi
    mkdir /data/misc/dhcp 0770 dhcp dhcp
    chown dhcp dhcp /data/misc/dhcp

    # Create the directories used by CnE subsystem
    mkdir /data/connectivity 0771 system system
    chown system system /data/connectivity

    mkdir /data/connectivity/nsrm 0771 system system
    chown system system /data/connectivity/nsrm

    # Create directory used by audio subsystem
    mkdir /data/misc/audio 0770 audio audio

    # Create directory used by the DASH client
    mkdir /data/misc/dash 0770 media audio

    # Mounting of persist is moved to 'on emmc-fs' and 'on fs' sections
    # We chown/chmod /persist again so because mount is run as root + defaults
    chown system system /persist
    chmod 0771 /persist
    chmod 0664 /sys/devices/platform/msm_sdcc.1/polling
    chmod 0664 /sys/devices/platform/msm_sdcc.2/polling
    chmod 0664 /sys/devices/platform/msm_sdcc.3/polling
    chmod 0664 /sys/devices/platform/msm_sdcc.4/polling

    # Chown polling nodes as needed from UI running on system server
    chown system system /sys/devices/platform/msm_sdcc.1/polling
    chown system system /sys/devices/platform/msm_sdcc.2/polling
    chown system system /sys/devices/platform/msm_sdcc.3/polling
    chown system system /sys/devices/platform/msm_sdcc.4/polling

    #Create the symlink to qcn wpa_supplicant folder for ar6000 wpa_supplicant
    mkdir /data/system 0775 system system
    #symlink /data/misc/wifi/wpa_supplicant /data/system/wpa_supplicant

    #Create directories for Location services
    mkdir /data/misc/location 0770 gps gps
    mkdir /data/misc/location/mq 0770 gps gps
    mkdir /data/misc/location/xtwifi 0770 gps gps
    mkdir /data/misc/location/gpsone_d 0770 system gps
    mkdir /data/misc/location/quipc 0770 gps system
    mkdir /data/misc/location/gsiff 0770 gps gps

    #Create directory from IMS services
    mkdir /data/shared 0755
    chown system system /data/shared

    #Create directory for FOTA
    mkdir /data/fota 0771
    chown system system /data/fota

    #Create directory for hostapd
    mkdir /data/hostapd 0770 system wifi

    # Create /data/time folder for time-services
    mkdir /data/time/ 0700 system system

    mkdir /data/audio/ 0770 media audio

    setprop vold.post_fs_data_done 1

    #Create a folder for SRS to be able to create a usercfg file
    mkdir /data/data/media 0770 media media

    #Grant access to system UID for SMSC HUB sysfs entry
    chown system system /sys/bus/platform/devices/msm_smsc_hub/enable

# Export GPIO56 for fusion targets to enable/disable hub
service usbhub_init /system/bin/usbhub_init
   class late_start
   user root
   disabled
   oneshot

service qcomsysd /system/bin/qcom-system-daemon
    class main

on property:sys.boot_completed=1
    write /dev/kmsg "Boot completed "

on property:persist.radio.atfwd.start=false
    stop atfwd

# corefile limit and ETB enabling
on property:persist.debug.trace=1
    mkdir /data/core 0777 root root
    write /proc/sys/kernel/core_pattern "/data/core/%E.%p.%e"
    write /sys/devices/system/cpu/cpu1/online 1
    write /sys/devices/system/cpu/cpu2/online 1
    write /sys/devices/system/cpu/cpu3/online 1
    write /sys/bus/coresight/devices/coresight-etm0/enable 0
    write /sys/bus/coresight/devices/coresight-etm1/enable 0
    write /sys/bus/coresight/devices/coresight-etm2/enable 0
    write /sys/bus/coresight/devices/coresight-etm3/enable 0
    write /sys/bus/coresight/devices/coresight-etm0/reset 1
    write /sys/bus/coresight/devices/coresight-etm1/reset 1
    write /sys/bus/coresight/devices/coresight-etm2/reset 1
    write /sys/bus/coresight/devices/coresight-etm3/reset 1
    write /sys/bus/coresight/devices/coresight-etm0/enable 1
    write /sys/bus/coresight/devices/coresight-etm1/enable 1
    write /sys/bus/coresight/devices/coresight-etm2/enable 1
    write /sys/bus/coresight/devices/coresight-etm3/enable 1

on property:ro.board.platform=msm7630_fusion
    start usbhub_init

on property:init.svc.wpa_supplicant=stopped
    stop dhcpcd

on property:bluetooth.isEnabled=true
    start btwlancoex
    write /sys/class/bluetooth/hci0/idle_timeout 7000

on property:bluetooth.sap.status=running
    start bt-sap

on property:bluetooth.sap.status=stopped
    stop bt-sap

on property:bluetooth.dun.status=running
    start bt-dun

on property:bluetooth.dun.status=stopped
    stop bt-dun

on property:ro.bluetooth.ftm_enabled=true
    start ftmd

service qcom-c_core-sh /system/bin/sh /init.qcom.class_core.sh
    class core
    user root
    oneshot

service qcom-c_main-sh /system/bin/sh /init.class_main.sh
    class main
    user root
    oneshot

on property:vold.decrypt=trigger_restart_framework
    start qcom-c_main-sh
    start config_bluetooth

on property:persist.env.fastdorm.enabled=true
    setprop persist.radio.data_no_toggle 1

service cnd /system/bin/cnd
    class late_start
    socket cnd stream 660 root inet

service irsc_util /system/bin/logwrapper /system/bin/irsc_util "/etc/sec_config"
    class main
    user root
    oneshot

service rmt_storage /system/bin/rmt_storage
    class core
    user root
    disabled

on property:ro.boot.emmc=true
    start rmt_storage

service rfs_access /system/bin/rfs_access
   class core
   user system
   group system net_raw

on property:ro.boot.emmc=true
    start rfs_access

on property:bluetooth.start_hci=true
    start start_hci_filter

on property:bluetooth.start_hci=false
    stop start_hci_filter

service start_hci_filter /system/bin/wcnss_filter
    class late_start
    user bluetooth
    group bluetooth
    disabled

service config_bluetooth /system/bin/sh /system/etc/init.qcom.bt.sh "onboot"
    class core
    user root
    oneshot

service hciattach /system/bin/sh /system/etc/init.qcom.bt.sh
    class late_start
    user bluetooth
    group bluetooth net_bt_admin
    disabled
    oneshot

on property:bluetooth.hciattach=true
    start hciattach

on property:bluetooth.hciattach=false
    setprop bluetooth.status off

service hciattach_ath3k /system/bin/sh /system/etc/init.ath3k.bt.sh
     class late_start
     user bluetooth
     group system bluetooth net_bt_admin misc
     disabled
     oneshot

service bt-dun /system/bin/dun-server /dev/smd7 /dev/rfcomm0
    class late_start
    user bluetooth
    group bluetooth net_bt_admin inet
    disabled
    oneshot

service bt-sap /system/bin/sapd 15
    user bluetooth
    group bluetooth net_bt_admin
    class late_start
    disabled
    oneshot

service ftmd /system/bin/logwrapper /system/bin/ftmdaemon
    class late_start
    user root
    group bluetooth net_bt_admin misc net_bt_stack qcom_diag
    disabled
    oneshot

service bridgemgrd /system/bin/bridgemgrd
    class late_start
    user radio
    group radio qcom_diag
    disabled

service port-bridge /system/bin/port-bridge /dev/smd0 /dev/ttyGS0
    class late_start
    user system
    group system inet
    disabled

service qmiproxy /system/bin/qmiproxy
    class main
    user radio
    group radio qcom_diag
    disabled

# QMUX must be in multiple groups to support external process connections
service qmuxd /system/bin/qmuxd
    class main
    user radio
    group radio audio bluetooth gps qcom_diag
    disabled

service netmgrd /system/bin/netmgrd
    class main
    disabled

service sensors /system/bin/sensors.qcom
    class late_start
    user root
    group root
    disabled

on property:ro.use_data_netmgrd=false
    # netmgr not supported on specific target
    stop netmgrd

# Adjust socket buffer to enlarge TCP receive window for high bandwidth
# but only if ro.data.large_tcp_window_size property is set.
on property:ro.data.large_tcp_window_size=true
    write /proc/sys/net/ipv4/tcp_adv_win_scale  2

service btwlancoex /system/bin/sh /system/etc/init.qcom.coex.sh
    class late_start
    user bluetooth
    group bluetooth net_bt_admin inet net_admin net_raw
    disabled
    oneshot

service amp_init /system/bin/amploader -i
    class late_start
    user root
    disabled
    oneshot

service amp_load /system/bin/amploader -l 7000
    class late_start
    user root
    disabled
    oneshot

service amp_unload /system/bin/amploader -u
    class late_start
    user root
    disabled
    oneshot

service p2p_supplicant /system/bin/wpa_supplicant \
    -ip2p0 -Dnl80211 -c/data/misc/wifi/p2p_supplicant.conf \
    -I/system/etc/wifi/p2p_supplicant_overlay.conf -N \
    -iwlan0 -Dnl80211 -c/data/misc/wifi/wpa_supplicant.conf \
    -I/system/etc/wifi/wpa_supplicant_overlay.conf \
    -O/data/misc/wifi/sockets -puse_p2p_group_interface=1 -dd \
    -e/data/misc/wifi/entropy.bin -g@android:wpa_wlan0
#   we will start as root and wpa_supplicant will switch to user wifi
#   after setting up the capabilities required for WEXT
#   user wifi
#   group wifi inet keystore
    class main
    socket wpa_wlan0 dgram 660 wifi wifi
    disabled
    oneshot

service wpa_supplicant /system/bin/wpa_supplicant \
    -iwlan0 -Dnl80211 -c/data/misc/wifi/wpa_supplicant.conf \
    -I/system/etc/wifi/wpa_supplicant_overlay.conf \
    -O/data/misc/wifi/sockets -dd \
    -e/data/misc/wifi/entropy.bin -g@android:wpa_wlan0
    #   we will start as root and wpa_supplicant will switch to user wifi
    #   after setting up the capabilities required for WEXT
    #   user wifi
    #   group wifi inet keystore
    class main
    socket wpa_wlan0 dgram 660 wifi wifi
    disabled
    oneshot

service dhcpcd_wlan0 /system/bin/dhcpcd -ABKLG
    class late_start
    disabled
    oneshot

service dhcpcd_p2p /system/bin/dhcpcd -ABKLG
    class late_start
    disabled
    oneshot

service iprenew_wlan0 /system/bin/dhcpcd -n
    class late_start
    disabled
    oneshot

service iprenew_p2p /system/bin/dhcpcd -n
    class late_start
    disabled
    oneshot

service ptt_socket_app /system/bin/ptt_socket_app -d -f
    class main
    user root
    group root
    disabled
    oneshot

service ptt_ffbm /system/bin/ptt_socket_app -f -d
    user root
    group root
    disabled
    oneshot

service dhcpcd_bt-pan /system/bin/dhcpcd -BKLG
    class late_start
    disabled
    oneshot

service iprenew_bt-pan /system/bin/dhcpcd -n
    class late_start
    disabled
    oneshot

service dhcpcd_bnep0 /system/bin/dhcpcd -BKLG
    disabled
    oneshot

service dhcpcd_bnep1 /system/bin/dhcpcd -BKLG
    disabled
    oneshot

service dhcpcd_bnep2 /system/bin/dhcpcd -BKLG
    disabled
    oneshot

service dhcpcd_bnep3 /system/bin/dhcpcd -BKLG
    disabled
    oneshot

service dhcpcd_bnep4 /system/bin/dhcpcd -BKLG
    disabled
    oneshot

service gpsone_daemon /system/bin/gpsone_daemon
    class late_start
    user gps
    group gps inet net_raw
    disabled

service quipc_igsn /system/bin/quipc_igsn
    class late_start
    user gps
    group inet gps qcom_diag
    disabled

service quipc_main /system/bin/quipc_main
    class late_start
    user gps
    group gps net_admin wifi inet qcom_diag
    disabled

service location_mq /system/bin/location-mq
    class late_start
    user gps
    group gps
    disabled

service xtwifi_inet /system/bin/xtwifi-inet-agent
    class late_start
    user gps
    group inet gps
    disabled

service xtwifi_client /system/bin/xtwifi-client
    class late_start
    user gps
    group net_admin wifi inet gps
    disabled

service lowi-server /system/bin/lowi-server
    class late_start
    user gps
    group gps net_admin wifi inet qcom_diag
    disabled

service fm_dl /system/bin/sh /system/etc/init.qcom.fm.sh
    class late_start
    user root
    group system fm_radio
    disabled
    oneshot

on property:crypto.driver.load=1
     insmod /system/lib/modules/qce.ko
     insmod /system/lib/modules/qcedev.ko

service drmdiag /system/bin/drmdiagapp
    class late_start
     user root
     disabled
     oneshot

on property:drmdiag.load=1
    start drmdiag

on property:drmdiag.load=0
    stop drmdiag

service qcom-sh /system/bin/sh /init.qcom.sh
    class late_start
    user root
    oneshot

service qcom-post-boot /system/bin/sh /system/etc/init.qcom.post_boot.sh
    class late_start
    user root
    disabled
    oneshot

service wifi-sdio-on /system/bin/sh /system/etc/init.qcom.sdio.sh
    class late_start
    group wifi inet
    disabled
    oneshot

service wifi-crda /system/bin/sh /system/etc/init.crda.sh
   class late_start
   user root
   disabled
   oneshot


on property:sys.boot_completed=1
    start qcom-post-boot

service atfwd /system/bin/ATFWD-daemon
    class late_start
    user system
    group system radio

service hostapd /system/bin/hostapd -dddd /data/hostapd/hostapd.conf
    class late_start
    user root
    group root
    oneshot
    disabled

service ds_fmc_appd /system/bin/ds_fmc_appd -p "rmnet0" -D
    class late_start
    group radio wifi inet
    disabled
    oneshot

on property:persist.data.ds_fmc_app.mode=1
    start ds_fmc_appd

service ims_regmanager /system/bin/exe-ims-regmanagerprocessnative
    class late_start
    group net_bt_admin inet radio wifi
    disabled

on property:persist.ims.regmanager.mode=1
    start ims_regmanager

on property:ro.data.large_tcp_window_size=true
    # Adjust socket buffer to enlarge TCP receive window for high bandwidth (e.g. DO-RevB)
    write /proc/sys/net/ipv4/tcp_adv_win_scale  2

service battery_monitor /system/bin/battery_monitor
    user system
    group system
    disabled

service ril-daemon1 /system/bin/rild -c 1
    class main
    socket rild1 stream 660 root radio
    socket rild-debug1 stream 660 radio system
    user root
    disabled
    group radio cache inet misc audio sdcard_r sdcard_rw diag qcom_diag log

service ril-daemon2 /system/bin/rild -c 2
    class main
    socket rild2 stream 660 root radio
    socket rild-debug2 stream 660 radio system
    user root
    disabled
    group radio cache inet misc audio sdcard_r sdcard_rw diag qcom_diag log

service usb_uicc_daemon /system/bin/usb_uicc_client
    class main
    user system
    group system log
    oneshot

on property:usb_uicc.spi_bridge_enabled=1
    insmod /system/lib/modules/ice40-hcd.ko

on property:usb_uicc.spi_bridge_enabled=0
    rmmod /system/lib/modules/ice40-hcd.ko

service profiler_daemon /system/bin/profiler_daemon
    class late_start
    user root
    group root
    disabled

service sdcard /system/bin/sdcard -u 1023 -g 1023 -l /data/media /mnt/shell/emulated
    class late_start

service fuse_sdcard1 /system/bin/sdcard -u 1023 -g 1023 -w 1023 -d /mnt/media_rw/sdcard1 /storage/sdcard1
    class late_start
    disabled

service fuse_uicc0 /system/bin/sdcard -u 1023 -g 1023 -w 1023 -d /mnt/media_rw/uicc0 /storage/uicc0
    class late_start
    disabled

service fuse_usbotg /system/bin/sdcard -u 1023 -g 1023 -d /mnt/media_rw/usbotg /storage/usbotg
    class late_start
    disabled

# Binding fuse mount point to /storage/emulated/legacy
on property:init.svc.sdcard=running
    wait /mnt/shell/emulated/0
    mount none /mnt/shell/emulated/0 /storage/emulated/legacy bind

service hcidump /system/bin/sh /system/etc/hcidump.sh
    user bluetooth
    group bluetooth system net_bt_admin net_admin
    disabled
    oneshot

service charger /sbin/chargeonlymode
    class charger

service ssr_diag /system/bin/ssr_diag
    class late_start
    user system
    group system

# SSR setting
on property:persist.sys.ssr.restart_level=*
    exec /system/bin/sh /init.qcom.ssr.sh ${persist.sys.ssr.restart_level}

# Define fastmmi
service fastmmi /system/bin/mmi
    user root
    group root
    disabled

service fastmmisrv /system/bin/sh /init.qcom.factory.sh
    user root
    disabled
    oneshot

on ffbm
    start fastmmisrv

service hvdcp /system/bin/hvdcp
    class core
    user root
    disabled

on property:persist.usb.hvdcp.detect=true
    start hvdcp

on property:persist.usb.hvdcp.detect=false
    stop hvdcp

service charger_monitor /system/bin/charger_monitor
    user system
    group system
    disabled

service qbcharger /charger -m 1
    disabled
    oneshot

on property:sys.qbcharger.enable=true
    start qbcharger

on property:sys.qbcharger.enable=false
    stop qbcharger

service diag_mdlog_start /system/bin/diag_mdlog -c -n 20
    class late_start
    group system qcom_diag sdcard_rw sdcard_r media_rw
    disabled
    oneshot

service diag_mdlog_stop /system/bin/diag_mdlog -k
    class late_start
    group system qcom_diag sdcard_rw sdcard_r media_rw
    disabled
    oneshot

service modem_dump /system/bin/subsystem_ramdump 2 0
    group system radio
    disabled

on property:persist.radio.ramdump_sdcard=1
    write /sys/module/subsystem_restart/parameters/enable_ramdumps 1
    start modem_dump

service qlogd /system/xbin/qlogd
    class main
    disabled
on property:persist.sys.qlogd=1
    start qlogd
on property:persist.sys.qlogd=0
    stop qlogd

service rootagent /system/bin/sh /system/etc/init.qcom.rootagent.sh
    disabled
    oneshot
on property:persist.sys.rootagent=1
    start rootagent
on property:persist.sys.rootagent=0
    stop rootagent

