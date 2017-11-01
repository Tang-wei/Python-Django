
from django.conf.urls import url
from . import views,viewsgoods,viewsdindan

urlpatterns = [
	# 后台首页
    url(r'^$', views.index,name='myadmin_index'),

    # 后台管理员路由
    url(r'^login$',views.login,name='myadmin_login'),
    url(r'^dologin$',views.dologin,name='myadmin_dologin'),
    url(r'^logout$',views.logout,name='myadmin_logout'),
    # 验证码路由
    url(r'^verify$',views.verify,name='myadmin_verify'),
    # 

    # 后台用户管理
    url(r'^users$',views.usersindex, name='myadmin_usersindex'),
    url(r'^usersadd$',views.usersadd, name='myadmin_usersadd'),
    url(r'^usersinsert$',views.usersinsert, name='myadmin_usersinsert'),
    url(r'^usersdel/(?P<uid>[0-9]+)$',views.usersdel, name='myadmin_usersdel'),
    url(r'^usersedit/(?P<uid>[0-9]+)$',views.usersedit, name='myadmin_usersedit'),
    url(r'^usersupdate/(?P<uid>[0-9]+)$',views.usersupdate, name='myadmin_usersupdate'),
    # 实现用户管理分页
    url(r'^usersye/(?P<pIndex>[0-9]+)$', views.usersye, name='usersye'),

    # 后台商品类别管理
    url(r'^types$',viewsgoods.typesindex, name='myadmin_typesindex'),
    url(r'^typesadd/(?P<tid>[0-9]+)$',viewsgoods.typesadd, name='myadmin_typesadd'),
    url(r'^typesinsert$',viewsgoods.typesinsert, name='myadmin_typesinsert'),
    url(r'^typesdel/(?P<tid>[0-9]+)$',viewsgoods.typesdel, name='myadmin_typesdel'),
    url(r'^typesedit/(?P<tid>[0-9]+)$',viewsgoods.typesedit, name='myadmin_typesedit'),
    url(r'^typesupdate/(?P<tid>[0-9]+)$',viewsgoods.typesupdate, name='myadmin_typesupdate'),

    # 后台商品信息管理
    # 后台商品类别管理
    url(r'^goods$',viewsgoods.goodsindex, name='myadmin_goodsindex'),
    url(r'^goodsadd$',viewsgoods.goodsadd, name='myadmin_goodsadd'),
    url(r'^goodsinsert$',viewsgoods.goodsinsert, name='myadmin_goodsinsert'),
    url(r'^goodsdel/(?P<gid>[0-9]+)$',viewsgoods.goodsdel, name='myadmin_goodsdel'),
    url(r'^goodsedit/(?P<gid>[0-9]+)$',viewsgoods.goodsedit, name='myadmin_goodsedit'),
    url(r'^goodsupdate/(?P<gid>[0-9]+)$',viewsgoods.goodsupdate, name='myadmin_goodsupdate'),

    # 订单表页面
    url(r'^dindan$',viewsdindan.dindan, name='myadmin_dindan'),
    
    # 订单详情表页面
    url(r'^xiangqin/(?P<gid>[0-9]+)$',viewsdindan.xiangqin, name='myadmin_xiangqin'),
    
    
]
