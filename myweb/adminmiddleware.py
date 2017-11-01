# 自定义后台中间件类
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
import re

class AdminMiddleware(object):
	# 初始化
	def __init__(self,get_response):
		self.get_response = get_response

	def __call__(self,request):
		# 定义网站后台不登陆可访问的后台
		urllist = ['/myadmin/login','/myadmin/dologin','/myadmin/logout','/myadmin/verify']
		# 获取当前请求路径
		path = request.path
		# 判断当前请求师傅访问网站后台 且path不在urllist中
		if re.match('/myadmin',path) and (path not in urllist):
			# 判断当前是否登录
			if 'adminuser' not in request.session:
				# 执行登录页面跳转
				return redirect(reverse('denlu'))

		response = self.get_response(request)

		return response

