

dnctl pipe 1 config bw 56Kbit/s delay 200ms
dnctl pipe 2 config bw 56Kbit/s delay 200ms

pf.conf
dummynet in all pipe 1
dummynet out all pipe 2
