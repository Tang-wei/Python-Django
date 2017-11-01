from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse 

from myadmin.models import Users,Orders,Detail

import time,json


# 订单表页面
def dindan(request):
	# 获取订单数据并放入页面中s
	lists = Orders.objects.all()
	context = {"orderslist":lists}
	# return HttpResponse(list)
	return render(request,'myadmin/dindan/index.html',context)


# 订单详情表页面
def xiangqin(request,gid):
	try:
		context ={}
		context['op']= Detail.objects.filter(orderid=gid)
			
		return render(request,'myadmin/dindan/index1.html',context)
	except:
		context = {'info':'没有订单详情!'}
	return render(request,'myadmin/info.html',context) 
	