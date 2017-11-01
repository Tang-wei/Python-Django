from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse 

from myadmin.models import Users

import time,json


# 后台首页

# 后台会员管理操作
# 验证码
def verify(request):
	#引入随机函数模块
	import random
	from PIL import Image, ImageDraw, ImageFont
	#定义变量，用于画面的背景色、宽、高
	#bgcolor = (random.randrange(20, 100), random.randrange(
	#    20, 100),100)
	bgcolor = (242,164,247)
	width = 100
	height = 25
	#创建画面对象
	im = Image.new('RGB', (width, height), bgcolor)
	#创建画笔对象
	draw = ImageDraw.Draw(im)
	#调用画笔的point()函数绘制噪点
	for i in range(0, 100):
		xy = (random.randrange(0, width), random.randrange(0, height))
		fill = (random.randrange(0, 255), 255, random.randrange(0, 255))
		draw.point(xy, fill=fill)
	#定义验证码的备选值
	str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
	#随机选取4个值作为验证码
	rand_str = ''
	for i in range(0, 4):
		rand_str += str1[random.randrange(0, len(str1))]
	#构造字体对象，ubuntu的字体路径为“/usr/share/fonts/truetype/freefont”
	font = ImageFont.truetype('static/STXIHEI.TTF', 21)
	#font = ImageFont.load_default().font
	#构造字体颜色
	fontcolor0 = (255, random.randrange(0, 255), random.randrange(0, 255))
	fontcolor1 = (255, random.randrange(0, 255), random.randrange(0, 255))
	fontcolor2 = (255, random.randrange(0, 255), random.randrange(0, 255))
	fontcolor3 = (255, random.randrange(0, 255), random.randrange(0, 255))
	#绘制4个字
	draw.text((5, 0), rand_str[0], font=font, fill=fontcolor0)
	draw.text((25, 1), rand_str[1], font=font, fill=fontcolor1)
	draw.text((50, 1), rand_str[2], font=font, fill=fontcolor2)
	draw.text((75, 0), rand_str[3], font=font, fill=fontcolor3)
	#释放画笔
	del draw
	#存入session，用于做进一步验证
	request.session['verifycode'] = rand_str
	"""
    python2的为
    # 内存文件操作
    import cStringIO
    buf = cStringIO.StringIO()
    """
    # 内存文件操作-->此方法为python3的
	import io
	buf = io.BytesIO()
	#将图片保存在内存中，文件类型为png
	im.save(buf, 'png')
	#将内存中的图片数据返回给客户端，MIME类型为图片png
	return HttpResponse(buf.getvalue(), 'image/png')

# 会员登录表单
def login(request):
	return render(request,'myadmin/login.html')

#会员执行登录

def dologin(request):
	# 校验验证码
	verifycode = request.session['verifycode']
	code = request.POST['code']
	if verifycode != code:
		context = {'info':'验证码错误!'}
		return render(request,'myadmin/login.html',context)
	try:
		# 根据帐号获取登录着信息
		user = Users.objects.get(username=request.POST['username'])
		# 判断当前是否是后台管理员
		if user.state ==0:
			# 验证密码
			import hashlib
			m = hashlib.md5()
			m.update(bytes(request.POST['password'],encoding='utf8'))
			# 判断密码是否相等
			if user.password == m.hexdigest():
				# 此处登录成功 将当前信息放入session中 并跳转到页面
				request.session['adminuser'] = user.name
				return redirect(reverse('myadmin_index'))
			else:
				context = {'info':'登录密码错误!'}
		else:
			context = {'info':'此用户非后台管理员用户!'}
	except:
		context = {'info':'登录帐号错误!'}
	return render(request,'myadmin/login.html',context)

# 会员退出
def logout(request):
	# 清除登录的session信息
	del request.session['adminuser']
	# 跳转登录页面url 地址改变
	return redirect(reverse('myadmin_login'))
#后台主页面 
def index(request):
	return render(request,"myadmin/index.html")

#会员用户浏览
def usersindex(request):
	list = Users.objects.all()
	context = {"userslist":list}
	return render(request,"myadmin/users/index.html",context)

# 会员用户添加页面
def usersadd(request):
	return render(request,"myadmin/users/add.html")

# 执行会员用户添加
def usersinsert(request):
	try:
		ob = Users()
		ob.username = request.POST['username']
		ob.name = request.POST['name']
		#获取密码并md5
		import hashlib
		m = hashlib.md5() 
		m.update(bytes(request.POST['password'],encoding="utf8"))
		ob.password = m.hexdigest()
		ob.sex = request.POST['sex']
		ob.address = request.POST['address']
		ob.code = request.POST['code']
		ob.phone = request.POST['phone']
		ob.email = request.POST['email']
		ob.state = 1
		ob.addtime = time.time()
		ob.save()
		context = {'info':'添加成功！'}
	except:
		context = {'info':'添加失败！'}

	return render(request,"myadmin/info.html",context)


# 会员用户信息删除
def usersdel(request,uid):
	try:
	 	ob = Users.objects.get(id=uid)
	 	ob.delete()
	 	context = {'info':'删除成功!'}
	except:
		context = {'info':'删除失败!'}
	return render(request,"myadmin/info.html",context)
# 会员用户信息修改
def usersedit(request,uid):
	try:
		ob = Users.objects.get(id=uid)
		context = {'user':ob}
		return render(request,"myadmin/users/edit.html",context)
	except:
		context = {'info':'没有找到要修改的信息！'}
	return render(request,"myadmin/info.html",context)

def usersupdate(request,uid):
	try:
		ob = Users.objects.get(id=uid)
		ob.name = request.POST['name']
		ob.sex = request.POST['sex']
		ob.address = request.POST['address']
		ob.code = request.POST['code']
		ob.phone = request.POST['phone']
		ob.email = request.POST['email']
		ob.state = request.POST['state']
		ob.save()
		context = {'info':'修改成功！'}
	except:
		context = {'info':'修改失败！'}
	return render(request,"myadmin/info.html",context)

#用户页面分页
def usersye(request,pIndex):
    # return HttpResponse('ok')
    list = Users.objects.all()
    #实例化分页对象
    p = Paginator(list,3)
    print(list)
    # 处理当前页号信息
    if pIndex=="":

        pIndex = '1'
    pIndex = int(pIndex)
    # 获取当前页数据
    list2 = p.page(pIndex)
    plist = p.page_range
    return render(request,"myadmin/users/index.html",{'userslist':list2,'pIndex':pIndex,'plist':plist})
