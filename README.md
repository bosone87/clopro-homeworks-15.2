# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашних заданий.

---
## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.

[**Terraform**](ter/)

[nlb.tf](ter/nlb.tf)
[ig.tf](ter/ig.tf)
[bucket.tf](ter/bucket.tf)
[sa.tf](ter/sa.tf)
[main.tf](ter/main.tf)
[network.tf](ter/network.tf)
[variables.tf](ter/variables.tf)
[locals.tf](ter/locals.tf)
[output.tf](ter/output.tf)
[providers.tf](ter/providers.tf)

**Разворачиваем инфраструктуру**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_ter_apply.png">
</p>

**Сайт доступен**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_web_pic1.png">
</p>

**ВМ**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_yc_vm.png">
</p>

**Network Load Balancer**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_yc_nlb.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/nlb_yc_nlb1.png">
</p>

**Object Storage**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_yc_os.png">
</p>

**Backet**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_pic_bak.png">
</p>

**Удаляем 2 ВМ**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_yc_del_vm.png">
</p>

**Одна ВМ восстанавливается**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_yc_prov_vm.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/nlb_yc_prov_vm1.png">
</p>

**Сайт остаётся доступным**

<p align="center">
    <img width="1200 height="600" src="/img/nlb_web_pic2.png">
</p>

4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

[**Terraform**](ter_alb/)

[alb.tf](ter_alb/alb.tf)
[ig.tf](ter_alb/ig.tf)
[bucket.tf](ter_alb/bucket.tf)
[sa.tf](ter_alb/sa.tf)
[main.tf](ter_alb/main.tf)
[network.tf](ter_alb/network.tf)
[variables.tf](ter_alb/variables.tf)
[locals.tf](ter_alb/locals.tf)
[output.tf](ter_alb/output.tf)
[providers.tf](ter_alb/providers.tf)

**Разворачиваем инфраструктуру**

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_ter_apply.png">
</p>

**Приложение доступно**

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_web_pic1.png">
</p>

**Application Load Balancer**

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_yc_alb.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_yc_alb1.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_yc_alb2.png">
</p>

**Instance group**

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_yc_ig.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_yc_ig1.png">
</p>

**Удаляем 2 ВМ**

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_yc_del_vm.png">
</p>

**Автоматически восстанавливаются 2 ВМ**

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_yc_prov_vm.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_yc_prov_ig.png">
</p>

**Приложение остаётся доступным**

<p align="center">
    <img width="1200 height="600" src="/img/alb/alb_web_pic2.png">
</p>


Полезные документы:

- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group).
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer).
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).

---
## Задание 2*. AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

Используя конфигурации, выполненные в домашнем задании из предыдущего занятия, добавить к Production like сети Autoscaling group из трёх EC2-инстансов с  автоматической установкой веб-сервера в private домен.

1. Создать бакет S3 и разместить в нём файл с картинкой:

 - Создать бакет в S3 с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать доступным из интернета.
2. Сделать Launch configurations с использованием bootstrap-скрипта с созданием веб-страницы, на которой будет ссылка на картинку в S3. 
3. Загрузить три ЕС2-инстанса и настроить LB с помощью Autoscaling Group.

Resource Terraform:

- [S3 bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Launch Template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template).
- [Autoscaling group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group).
- [Launch configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration).

Пример bootstrap-скрипта:

```
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>" > index.html
```
### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
