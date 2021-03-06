#!/bin/sh
ctl01_mask="ctl01"
cmp_mask="cmp"
echo "Using node masks: Control node ${ctl01_mask}, Compute nodes ${cmp_mask}"
echo "Gathering the nova data, this may take a while"
sudo salt -C "${ctl01_mask}*" cmd.run ". /root/keystonercv3; nova --debug list --all --limit -1" > nova_vms
echo "Gathering the virsh data, this may take even longer"
sudo salt -t 10 -C "${cmp_mask}*" cmd.run 'bash -c "paste <(virsh list --all --uuid) <(virsh list --all | grep instance)"' > virsh_vms
