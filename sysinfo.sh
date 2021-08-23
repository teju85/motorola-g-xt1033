#!/bin/bash
outfile=${1:-devinfo}
batteryRootFile=${2:-/sys/class/power_supply/battery}
ADB=${3:-platform-tools/adb}

function getCommandOutput() {
    local cmd=$1
    echo "### CMD START: $cmd ###"
    $ADB shell "$cmd" | dos2unix | dos2unix
    echo "### CMD END: $cmd ###"
    echo
    echo
}

function getFileContents() {
    getCommandOutput "cat $1"
}

function collectAllInfo() {
    getFileContents /default.prop
    getFileContents /system/build.prop
    getFileContents /proc/cpuinfo
    getFileContents /proc/meminfo
    getFileContents /proc/mounts
    getFileContents /proc/partitions
    getCommandOutput "ls -l /dev/block/platform/msm_sdcc.1/by-name"
    getCommandOutput df
    getCommandOutput uptime
    getCommandOutput getprop
    echo "### CMD START: Battery Info ###"
    for type in capacity health status technology; do
        echo -n "$type: "
        $ADB shell "cat $batteryRootFile/$type" | dos2unix | dos2unix
    done
    echo "### CMD END: Battery Info ###"
}

echo "Connect and enable USB-debugging on your device"
$ADB devices
echo "Collecting system info into outfile=$outfile..."
collectAllInfo > $outfile
