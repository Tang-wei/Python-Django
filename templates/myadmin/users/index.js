
// <script type="text/javascript">
	//声明全局变量
	var NameOk = false;
	var PassOk = false;
	var EmailOk = false;

	//获取焦点事件 focus
	$('input').focus(function(){
		//获取焦点时,给予提示信息
		var at = $(this).attr('readme');
		$(this).next('span').html(at).css('color','blue');
		$(this).css('border','1px solid blue');
	})

	//绑定丧失焦点事件 blur
	$('input[name=username]').blur(function(){
		//获取用户的输入信息
		var v = $(this).val();
		var reg = /^\w{6,18}$/;
		if(reg.test(v)){
			$(this).next('span').html('√').css('color','green');
			$(this).css('border','1px solid green');
			//修改全局变量
			NameOk = true;
		}else{
			$(this).next('span').html('用户名格式不正确').css('color','red');
			$(this).css('border','1px solid red');
			//修改全局变量
			NameOk = false;
		}
	})

	//绑定丧失焦点事件 blur
	$('input[name=password]').blur(function(){
		//获取用户的输入信息
		var v = $(this).val();
		var reg = /^\w{6,18}$/;
		if(reg.test(v)){
			$(this).next('span').html('√').css('color','green');
			$(this).css('border','1px solid green');
			//修改全局变量
			PassOk = true;
		}else{
			$(this).next('span').html('密码格式不正确').css('color','red');
			$(this).css('border','1px solid red');
				//修改全局变量
			PassOk = false;
		}
	})

		//绑定丧失焦点事件 blur
	$('input[name=email]').blur(function(){
		//获取用户的输入信息
		var v = $(this).val();
		var reg = /^\w+@\w+\.(com|cn|org|net)$/;
		if(reg.test(v)){
			$(this).next('span').html('√').css('color','green');
			$(this).css('border','1px solid green');
			//修改全局变量
			EmailOk = true;
		}else{
			$(this).next('span').html('邮箱格式不正确').css('color','red');
			$(this).css('border','1px solid red');
			//修改全局变量
			EmailOk = false;
		}
	})

	

	//表单提交事件 submit
	$('form').submit(function(){
		//触发input 丧失焦点事件
		$('input').trigger('blur');

		//判断如果都正确
		if(NameOk && PassOk && EmailOk){
			return true;
		}
		//阻止默认行为
		return false;
	})



	// </script>