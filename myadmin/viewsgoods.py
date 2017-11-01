from django.shortcuts import render
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse 

from myadmin.models import Types,Goods
from PIL import Image
import time,json,os



# 后台商品类别列表
# 浏览商品类别列表
def typesindex(request):
	# 查询设置到模版中
	list = Types.objects.extra(select={'_has':'concat(path,id)'}).order_by('_has')
	# 遍历查询结果 为每个结果对象追加pname属性 ,目的用于缩进标题
	for ob in list:
		ob.pname = '...'*(ob.path.count(',')-1)
	context = {'typeslist':list}
	return render(request,"myadmin/types/index.html",context)

# 添加商品类别页
def typesadd(request,tid):
	
	# 获取父类信息  没有默认根类别
	if tid == '0':
		context = {'pid':0,'path':'0,','name':'根类别'}
	else:
		ob = Types.objects.get(id=tid)
		context = {'pid':ob.id,'path':ob.path+str(ob.id)+',','name':ob.name}
	return render(request,"myadmin/types/add.html",context)

# 商品类别添加执行
def typesinsert(request):
	try:
		ob = Types()
		ob.name = request.POST['name']
		ob.pid = request.POST['pid']
		ob.path = request.POST['path']
		ob.save()
		context = {'info':'添加成功!'}
	except:
		context = {'info':'添加失败!'}

	return render(request,'myadmin/info.html',context)

# 删除商品类别
def typesdel(request,tid):
	try:
		# 获取要删除的商品类别 若有子类别 不能删除
		row = Types.objects.filter(pid=tid).count()
		# 判断是否有子类别
		if row > 0:
			context = {'info':'删除失败!此类别下有子类别!'}
			return render(request,'myadmin/info.html',context)
		# 获取删除
		ob = Types.objects.get(id=tid)
		ob.delete()
		context = {'info':'删除成功!'}
	except:
		context = {'info':'删除失败!'}
	return render(request,'myadmin/info.html',context)

# 商品类别编辑页面
def typesedit(request,tid):
	try:
		ob = Types.objects.get(id=tid)
		context = {'types':ob}
		return render(request,'myadmin/types/edit.html',context)
	except:
		context = {'info':'没有找到要修改的内容!'}
	return render(request,'myadmin/info.html',context) 


# 修改商品类别执行页
def typesupdate(request,tid):
	try:
		ob = Types.objects.get(id=tid)
		ob.name = request.POST['name']
		ob.save()
		context = {'info':'修改成功!'}
	except:
		context = {'info':'修改失败!'}
		
	return render(request,'myadmin/info.html',context)


# 后台商品信息管理
# 浏览商品信息列表
def goodsindex(request):
	# 执行数据查询  并放到模版中
	list = Goods.objects.all()
	
	# 循环出 list中的值
	for ob in list:
		ty = Types.objects.get(id=ob.typeid)
		ob.typename = ty.name
		print
	context = {'goodslist':list}
	return render(request,"myadmin/goods/index.html",context)

# 添加商品信息页
def goodsadd(request):
	# 获取商品信息  获取商品的类信息
	list = Types.objects.extra(select = {'_has':'concat(path,id)'}).order_by('_has')
	context = {"typelist":list}
	return render(request,'myadmin/goods/add.html',context)
 # 商品信息添加执行
def goodsinsert(request):
	
	try:
		myfile = request.FILES.get("pic", None)

		if not myfile:
			return HttpResponse("没有上传文件信息！")
        # 以时间戳命名一个新图片名称
		filename= str(time.time())+"."+myfile.name.split('.').pop()
		destination = open(os.path.join("./static/goods/",filename),'wb+')
		for chunk in myfile.chunks():      # 分块写入文件  
			destination.write(chunk)  
		destination.close()

        # 执行图片缩放
		im = Image.open("./static/goods/"+filename)
        # 缩放到375*375:
		im.thumbnail((375, 375))
        # 把缩放后的图像用jpeg格式保存:
		im.save("./static/goods/"+filename, 'jpeg')
        # 缩放到220*220:
		im.thumbnail((220, 220))
        # 把缩放后的图像用jpeg格式保存:
		im.save("./static/goods/m_"+filename, 'jpeg')
        
        # 缩放到220*220:
		im.thumbnail((100, 100))
        # 把缩放后的图像用jpeg格式保存:
		im.save("./static/goods/s_"+filename, 'jpeg')

		# 获取商品信息执行
		ob = Goods()
		ob.goods = request.POST['goods']
		ob.typeid = request.POST['typeid']
		ob.company = request.POST['company']
		ob.price = request.POST['price']
		ob.store = request.POST['store']
		ob.descr = request.POST['descr']
		ob.picname = filename
		ob.state = 1
		ob.addtime = time.time()
		print(ob)
		ob.save()
		context = {'info':'添加成功!'}
	except:
		context = {'info':'添加失败!'}
	return render(request,'myadmin/info.html',context)

# 删除商品信息
def goodsdel(request,gid):
	try:
        # 获取被删除商品信的息量，先删除对应的图片
		ob = Goods.objects.get(id=gid)
        #执行图片删除
		os.remove("./static/goods/"+ob.picname)   
		os.remove("./static/goods/m_"+ob.picname)   
		os.remove("./static/goods/s_"+ob.picname)
        #执行商品信息的删除 
		ob.delete()
		context = {'info':'删除成功！'}
	except:
		context = {'info':'删除失败！'}
	return render(request,"myadmin/info.html",context)

# 修改商品信息
def goodsedit(request,gid):
	try:
		# 获取要编辑的信息
		ob  =  Goods.objects.get(id=gid)
		# 获取商品的类别信息
		list = Types.objects.extra(select = {'_has':'concat(path,id)'}).order_by('_has')
		# 放置信息加载模版
		context = {'typelist':list,'goods':ob}
		return render(request,'myadmin/goods/edit.html',context)
	except:
		context = {'info':'没有找到要修改的信息!'}
	return render(request,'myadmin/info.html',context)


# 修改商品信息执行页
def goodsupdate(request,gid):
	try:
		b = False
		oldpicname = request.POST['oldpicname']	
		if None != request.FILES.get("pic"):
			myfile = request.FILES.get("pic", None)
			if not myfile:
			    return HttpResponse("没有上传文件信息！")
			# 以时间戳命名一个新图片名称
			filename = str(time.time())+"."+myfile.name.split('.').pop()
			destination = open(os.path.join("./static/goods/",filename),'wb+')
			for chunk in myfile.chunks():      # 分块写入文件  
			    destination.write(chunk)  
			destination.close()
			# 执行图片缩放
			im = Image.open("./static/goods/"+filename)
			# 缩放到375*375:
			im.thumbnail((375, 375))
			# 把缩放后的图像用jpeg格式保存:
			im.save("./static/goods/"+filename, 'jpeg')
			# 缩放到220*220:
			im.thumbnail((220, 220))
			# 把缩放后的图像用jpeg格式保存:
			im.save("./static/goods/m_"+filename, 'jpeg')
			# 缩放到220*220:
			im.thumbnail((100, 100))
			# 把缩放后的图像用jpeg格式保存:
			im.save("./static/goods/s_"+filename, 'jpeg')
			b = True
			picname = filename
		else:
			picname = oldpicname
		ob = Goods.objects.get(id=gid)
		ob.goods = request.POST['goods']
		ob.typeid = request.POST['typeid']
		ob.company = request.POST['company']
		ob.price = request.POST['price']
		ob.store = request.POST['store']
		ob.descr = request.POST['descr']
		ob.picname = picname
		ob.state = request.POST['state']
		ob.save()
		context = {'info':'修改成功！'}
		if b:
			os.remove("./static/goods/m_"+oldpicname) #执行老图片删除  
			os.remove("./static/goods/s_"+oldpicname) #执行老图片删除  
			os.remove("./static/goods/"+oldpicname) #执行老图片删除  
	except:
		context = {'info':'修改失败！'}
		if b:
			os.remove("./static/goods/m_"+picname) #执行新图片删除  
			os.remove("./static/goods/s_"+picname) #执行新图片删除  
			os.remove("./static/goods/"+picname) #执行新图片删除  
	return render(request,"myadmin/info.html",context)