from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse 
from django.core.urlresolvers import reverse

from myweb.models import Users,Goods,Types,Orders,Detail

import time,json


# 定义公共函数都可以调用
def gongZhong(request):
	context = {}
	context['typelist'] = Types.objects.filter(pid=0)
	return context

# 浏览购物车
def gshop(request):
	# 调用函数
	context = gongZhong(request)
	# 判断当前购物车是否为空
	if 'shopl' not in request.session:
		request.session['shopl'] = {}
	return render(request,'myweb/shop/cart.html',context)

# 添加购物车
def gshopadd(request,gid):
	# 获取要放入购物车的商品信息
	good = Goods.objects.get(id=gid)
	# 获取models中的方法(字典 放入购物车中的值)
	shop = good.toDict()
	#shop = goods.__dict__
	#print(goods.__dict__)
	#print(shop)
	shop['m'] = int(request.POST['m'])
	# 从session中获取购物车的信息
	if 'shopl' in request.session:
		shopl = request.session['shopl']
	else:
		shopl = {}
	# 判断商品是否在购物车中
	if gid in shopl:
		# 在购车中数量加一
		shopl[gid]['m']+=shop['m']
	else:
		# 不在添加新商品
		shopl[gid] = shop 
	# 将购物车信息放入session中
	request.session['shopl'] = shopl
	return redirect(reverse('gshop'))
	#return render(request,'myweb/shop/cart.html')

# 删除购物车
def gshopdel(request,gid):
	shopl = request.session['shopl']
	del shopl[gid]
	request.session['shopl'] = shopl
	return redirect(reverse('gshop'))
	

# 清空购物车
def gshopclose(request):
	context = gongZhong(request)
	request.session['shopl'] = {}
	return render(request,'myweb/shop/cart.html',context)

# 更改商品数量
def gshopupdate(request):
	context = gongZhong(request)
	shopl = request.session['shopl']
	# 获取购物车的商品信息
	shopid = request.GET['gid']
	num = int(request.GET['num'])
	if num < 1:
		num = 1
	# 更改商品数量
	shopl[shopid]['m'] = num
	request.session['shopl'] = shopl
	return render(request,'myweb/shop/cart.html',context)



# 订单详情页
def xiangqin(request):
	lists = Detail.objects.all()
	context = {'detaillists':lists}

	return render(request,'myweb/shop/order.html',context)

# 结算页面
def jiesuan(request):
	#获取要结账的商品id信息
	ids = request.GET['gids']
	if ids == '':
	    return HttpResponse("请选择要结账的商品")
	gids = ids.split(',')
	# 获取购物车中的商品信息
	shopl = request.session['shopl']
	#封装要结账的商品信息，以及累计总金额
	orderlist = {}
	total = 0
	for sid in gids:
	    orderlist[sid] = shopl[sid]
	    total += shopl[sid]['price']*shopl[sid]['m'] #累计总金额.
	request.session['orderlist'] = orderlist
	request.session['total'] = total
	# 获取选中的session值
	
	# 清除已结算购物车的session信息
	del request.session['shopl']
    # 跳转登录页面（url地址改变）
	return render(request,'myweb/shop/queren.html')

# 结算添加数据
def jiesuanadd(request):
	# 封装订单信息，并执行添加
	orders = Orders()
	orders.uid = request.session['vipuser']['id']
	orders.linkman = request.POST['linkman']
	orders.address = request.POST['address']
	orders.code = request.POST['code']
	orders.phone = request.POST['phone']
	orders.addtime = time.time()
	orders.total = request.session['total']
	orders.status = 0
	orders.save()
	#获取订单详情
	orderlist = request.session['orderlist']
	#遍历购物信息，并添加订单详情信息
	for shop in orderlist.values():
	    print(shop)
	    detail = Detail()
	    detail.orderid = orders.id
	    detail.goodsid = shop['id']
	    detail.name = shop['goods']
	    detail.price = shop['price']
	    detail.num = shop['m']
	    detail.addtime = time.time()
	    detail.picname = shop['picname']
	    detail.save()
	return redirect(reverse('xiangqin'))


# 确认结算
def queren(request):
	return render(request,'myweb/shop/queren1.html')

