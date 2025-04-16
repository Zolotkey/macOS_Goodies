#!/usr/bin/env zsh

MSSDFLT="1448"
SENDSPACE="3125000"
RECVSPACE="3125000"
WIN_SCALE_FACTOR="6"
AUTORCVBUFMAX="4194304"
AUTOSNDBUFMAX="4194304"

MSSDFLT_TRUE=$(sysctl net.inet.tcp.mssdflt | awk '{print $2}')
SENDSPACE_TRUE=$(sysctl net.inet.tcp.sendspace | awk '{print $2}')
RECVSPACE_TRUE=$(sysctl net.inet.tcp.recvspace | awk '{print $2}')
WIN_SCALE_FACTOR_TRUE=$(sysctl net.inet.tcp.win_scale_factor | awk '{print $2}')
AUTORCVBUFMAX_TRUE=$(sysctl net.inet.tcp.autorcvbufmax | awk '{print $2}')
AUTOSNDBUFMAX_TRUE=$(sysctl net.inet.tcp.autosndbufmax | awk '{print $2}')


SYSCTL_TRUE=(${MSSDFLT_TRUE} ${SENDSPACE_TRUE} ${RECVSPACE_TRUE}
    ${WIN_SCALE_FACTOR_TRUE} ${AUTORCVBUFMAX_TRUE} ${AUTOSNDBUFMAX_TRUE} )

SYSCTL_WANT=(${MSSDFLT} ${SENDSPACE} ${RECVSPACE}
    ${WIN_SCALE_FACTOR} ${AUTORCVBUFMAX} ${AUTOSNDBUFMAX} )


if [[ ! -e /etc/sysctl.conf ]]; then
    exit 1
elif [[ ! ${SYSCTL_TRUE[@]} == ${SYSCTL_WANT[@]} ]]; then
    exit 1
else
    exit 0
fi
