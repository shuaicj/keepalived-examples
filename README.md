# Keepalived Examples

The config examples of keepalived, e.g. master-backup, master-master.
- In master-backup mode, if the nginx on master node failed to work, then the backup node will take it over.
- In master-master mode, if the nginx on any node failed to work, then the other node will take it over.

### Get Started

Tested on:
- Ubuntu 14.04
- Keepalived 1.2.7
- Nginx 1.4.6

```bash
sudo apt-get install keepalived nginx
sudo cp check_nginx.sh /etc/keepalived/
```

#### Master-Backup
The IPs:
```
master ip: 192.168.33.10
backup ip: 192.168.33.11
virtual ip: 192.168.33.50
```

On master node:
```bash
sudo cp master-backup/master/keepalived.conf /etc/keepalived/
sudo service keepalived start
```

On backup node:
```bash
sudo cp master-backup/backup/keepalived.conf /etc/keepalived/
sudo service keepalived start
```

Check:
1. Check logging messages in `/var/log/syslog` on each node.
2. Check the virtual ip status with the following command on each node:
```bash
ip a
```
3. Check priority changes on each node:
- on master: `sudo tcpdump -vvv -n -i eth1 host 192.168.33.10`
- on backup: `sudo tcpdump -vvv -n -i eth1 host 192.168.33.11`
4. Stop nginx on master and check 1, 2, 3 again:
```bash
sudo service nginx stop
```
5. Then start nginx on master and check 1, 2, 3 again:
```bash
sudo service nginx start
```

#### Master-Master
The IPs:
```
master ip: 192.168.33.10
backup ip: 192.168.33.11
virtual ip 1: 192.168.33.51
virtual ip 2: 192.168.33.52
```
And the other steps are similar to master-backup mode, except that you can stop the nginx on any node and the other node will take it over.

### Reference
- `man keepalived.conf`
- [Keepalived 1.2.7 Configuration Synopsis](https://github.com/acassen/keepalived/blob/v1.2.7/doc/keepalived.conf.SYNOPSIS)
- See comments in [master-backup keepalived.conf](master-backup/master/keepalived.conf)
