
from django.conf.urls import url

from . import views,viewsmember,viewsshop

urlpatterns = [
	# 前台首页
	url(r'^$', views.index, name="index"),

	

	# 前台列表页
	url(r'^lists$', views.lists, name="lists"),
	# 带参数列表页
	url(r'^lists/(?P<tid>[0-9]+)$', views.lists, name="lists2"),
	# 前台详情页
	# url(r'^det/(?P<tid>[0-9]+)$', views.det, name="det1"),
	url(r'detail/(?P<gid>[0-9]+)$', views.detail, name='detail'),


	# 购物车
	# 浏览购物车
	url(r'^gshop$',viewsshop.gshop, name='gshop'),
	# 添加购物车
	url(r'^gshopadd/(?P<gid>[0-9]+)$',viewsshop.gshopadd, name='gshopadd'),
	# 删除购物车
	url(r'^gshopdel/(?P<gid>[0-9]+)$',viewsshop.gshopdel, name='gshopdel'),
	# 清空购物车
	url(r'^gshopclose$',viewsshop.gshopclose, name='gshopclose'),
	# 更改购物车中商品数量
	url(r'^gshopupdate$',viewsshop.gshopupdate, name='gshopupdate'),



	# 订单处理
	# 订单详情页
	url(r'^xiangqin$',viewsshop.xiangqin, name='xiangqin'),
	# 结算页
	url(r'^jiesuan$',viewsshop.jiesuan, name='jiesuan'),
	# 结算页添加数据
	url(r'^jiesuanadd$',viewsshop.jiesuanadd, name='jiesuanadd'),
	# 结算确认页
	url(r'^queren$',viewsshop.queren, name='queren'),


	# 会员登录页面
	url(r'^denlu$',viewsmember.denlu, name='denlu'),
	# 执行登录
	url(r'^denlu1$',viewsmember.denlu1, name='denlu1'),
	# 退出登录
	url(r'^denlu2$',viewsmember.denlu2, name='denlu2'),

	# 会员注册页面
	url(r'^zhuce$',viewsmember.zhuce, name='zhuce'),
	# 执行注册
	url(r'^zhuce1$',viewsmember.zhuce1, name='zhuce1'),
	# 跳转登录页面
	url(r'^zhuce2$',viewsmember.zhuce2, name='zhuce2'),

	# 验证码路由
	url(r'^verify$',viewsmember.verify,name='myadmin_verify'),
	

	# 个人中心页面
	# 获取个人中心页面
	url(r'^geren$',viewsmember.geren, name='geren'),

	# 个人信息添加
	url(r'^gerenye$',viewsmember.gerenye, name='gerenye'),
	url(r'^gerenadd/(?P<uid>[0-9]+)$',viewsmember.gerenadd, name='gerenadd'),



]