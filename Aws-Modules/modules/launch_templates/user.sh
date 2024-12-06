MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
# Create papertrl user
useradd papertrl

# Add papertrl user to sudoers file with NOPASSWD for passwordless sudo
echo 'papertrl ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

--==MYBOUNDARY==--
