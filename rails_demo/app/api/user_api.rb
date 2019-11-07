#app/api/user_api.rb
class UserAPI < Grape::API
    # 返回的数据为json
    format :json
    before do
    header 'Access-Control-Allow-Origin',  '*' 
    header 'Content-Type', 'text/plain;charset=utf-8'
    header 'Access-Control-Allow-Methods','*'
    header 'Access-Control-Expose-Headers',''
    header 'Access-Control-Allow-Headers','Authorization,content-type,accept,Access-Control-Allow-Origin'
    end  
  
    # 可以使得API的路径更有意义
    # prefix :LYM
  
    # http://localhost:3000/get_user?real_name=采购人
    get 'get_user' do
      user = User.where(real_name: params[:real_name])
      {message: user}
    end
    post 'post_user' do
      user = User.where(real_name: params[:real_name])
      {message: user}
    end
  
    # http://localhost:3000/user/select_supplier?real_name=采购人
    resource :user do
      desc "返回一些数据"
      get :select_supplier do
        User.where(real_name: params[:real_name])
      end
    end
  
    get 'test' do
       users = User.all
      {message: users}
    end
    
    get 'test2' do
      user = User.find_by(username: params[:username], password: params[:password])
      {message: user}
    end
      
    
  def destroy
    session[:user_id] = nil
    flash[:notice] = "退出成功"
    redirect_to root_path
  end
  
  # optional可选项，requires必填项
  params do
    requires :username, type: String, desc: '用户名'
    requires :password, type: String, desc: '密码'
  end

  post 'register' do
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      {status:200}
    else
      {status:500}
    end
  end

  post 'login' do
  @user = User.find_by(username: params[:username], password: params[:password])
  if @user
  # session[:user_id] = @user.id
  {status:200,token:1,user:@user.username}
  # flash[:notice] = '登录成功'
  else
  {status:500}
  end 
end

end
  