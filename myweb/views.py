
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse 

from myadmin.models import Types,Goods

import time,json

# Create your views here.

# 自定义公共信息加载函数
def gongZhong(request):
	context = {}
	context['typelist'] = Types.objects.filter(pid=0)
	return context
# 前台首页
def index(request):
	lists = Goods.objects.all()
	context = {'golists':lists}
	context = gongZhong(request)
	# 获取首页所需商品信息并放到context
	return render(request,'myweb/index.html',context)

# 前台列表页
def lists(request,tid=0):
	context = gongZhong(request)
	# 获取所需商品列表信息并放置到context
	if tid == 0:
	    context['goodslist'] = Goods.objects.all()
	else:
	    #获取当前类别下的所有子类别信息
	    context['types'] = Types.objects.filter(pid=tid)
	    # 判断参数ttid是否有值
	    if request.GET.get('ttid',None):
	        context['goodslist'] = Goods.objects.filter(typeid=request.GET['ttid'])
	    else:
	        # 获取指定商品类别下的所有商品信息
	        context['goodslist'] = Goods.objects.filter(typeid__in=Types.objects.only('id').filter(path__contains=','+str(tid)+','))
	# 如tid=1的sql：select * from myweb_goods where typeid in(select id from myweb_type where path like '%,1,%')
	return render(request,'myweb/list.html',context)
# 前台详情页
def detail(request,gid):
	context = gongZhong(request)
	# 获取对应商品详情并放到context
	ob = Goods.objects.get(id=gid)

	ob.clicknum += 1
	ob.save()
	context['goods'] = ob
	return render(request,'myweb/detail.html',context)
