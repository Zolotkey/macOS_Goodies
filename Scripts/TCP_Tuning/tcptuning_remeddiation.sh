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


if [[ ! -e /etc/sysctl.conf && ! ${SYSCTL_TRUE[@]} == ${SYSCTL_WANT[@]} ]]; then
    /usr/sbin/sysctl net.inet.tcp.mssdflt=${MSSDFLT}
    /usr/sbin/sysctl net.inet.tcp.sendspace=${SENDSPACE}
    /usr/sbin/sysctl net.inet.tcp.recvspace=${RECVSPACE}
    /usr/sbin/sysctl net.inet.tcp.win_scale_factor=${WIN_SCALE_FACTOR}
    /usr/sbin/sysctl net.inet.tcp.autorcvbufmax=${AUTORCVBUFMAX}
    /usr/sbin/sysctl net.inet.tcp.autosndbufmax=${AUTOSNDBUFMAX}

    cat > /etc/sysctl.conf <<EOF
net.inet.tcp.mssdflt=1448
net.inet.tcp.sendspace=3125000
net.inet.tcp.recvspace=3125000
net.inet.tcp.win_scale_factor=6
net.inet.tcp.autorcvbufmax=4194304
net.inet.tcp.autosndbufmax=4194304
EOF
	sed -i '' '/^$/d' /etc/sysctl.conf
    exit 0
elif [[ ! -e /etc/sysctl.conf && ${SYSCTL_TRUE[@]} == ${SYSCTL_WANT[@]} ]]; then
    cat > /etc/sysctl.conf <<EOF
net.inet.tcp.mssdflt=1448
net.inet.tcp.sendspace=3125000
net.inet.tcp.recvspace=3125000
net.inet.tcp.win_scale_factor=6
net.inet.tcp.autorcvbufmax=4194304
net.inet.tcp.autosndbufmax=4194304
EOF
	sed -i '' '/^$/d' /etc/sysctl.conf
    exit 0
elif [[ -e /etc/sysctl.conf && ! ${SYSCTL_TRUE[@]} == ${SYSCTL_WANT[@]} ]]; then
    /usr/sbin/sysctl net.inet.tcp.mssdflt=${MSSDFLT}
    /usr/sbin/sysctl net.inet.tcp.sendspace=${SENDSPACE}
    /usr/sbin/sysctl net.inet.tcp.recvspace=${RECVSPACE}
    /usr/sbin/sysctl net.inet.tcp.win_scale_factor=${WIN_SCALE_FACTOR}
    /usr/sbin/sysctl net.inet.tcp.autorcvbufmax=${AUTORCVBUFMAX}
    /usr/sbin/sysctl net.inet.tcp.autosndbufmax=${AUTOSNDBUFMAX}
    exit 0
else
    echo "How did you get here with a remediation script?"
    exit 1
fi
