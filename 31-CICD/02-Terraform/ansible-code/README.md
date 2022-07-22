```
68  cp -rf 01-Inventory 02-Playbook 
   69  ls
   70  cd 02-Playbook/
   71  ls
   72  vim inventory 
   73  vim ansible.cfg
   74  ls
   75  cd 
   76  vim /etc/ansible/hosts 
   77  ls
   78  cd terraform-pwc-07-April-2022/
   79  ls
   80  cd 24-Ansible/
   81  ls
   82  cd 02-Playbook/
   83  ls
   84  vim inventory 
   85  ls
   86  vim ansible.cfg 
   87  ls
   88  mv inventory hosts
   89  ls
   90  ansible web -m shell  -a 'cat /etc/*-release' 
   91  vim playbook.yaml
   92  ansible-playbook playbook.yaml 
```
