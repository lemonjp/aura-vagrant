Aura PHP with Vagrant
=====================

vagrant file for a php aura project

## Environment

- Vagrant 1.6.5
- ubuntu/trusty64
- PHP 5.5
- MySQL 5.5
- Aura Framework 2.x

## Instllation

- at host machine

```sh
vagrant up
vagrant ssh

```
- at guest machine

```sh
su -
cd /var/www
composer create-project --stability=dev aura/framework-project aura_project

```

If you point your web browser to `http://192.168.22.10` you can see the message `Hello World!`.

please refer this tutorial bellow.

[2.x framework manual](http://auraphp.com/framework/2.x/en/)

