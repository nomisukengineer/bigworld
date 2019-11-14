# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success[211]' do
      get :new
      expect(response).to have_http_status(:success)
    end

    # 200レスポンスを返すこと
    it 'returns a 200 response[212]' do
      # sign_in @user
      get :new
      expect(response).to have_http_status '200'
    end
  end

  describe 'GET #show' do
    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user, password: 'nominomi1')
        get :show, params: { 'id' => @user.id }, session: { 'user_id' => @user.id }
      end

      it 'returns http success[213]' do
        expect(response).to have_http_status(:success)
      end
      it 'returns a 200 response[214]' do
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      before do
        fake_id = 1
        get :show, params: { 'id' => fake_id }, session: {}
      end
      it 'returns a 302 response[215]' do
        expect(response).to have_http_status '302'
      end

      it 'returns a 302 response[216]' do
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'POST #create' do
    context '入力する値に間違いがない場合' do
      before do
        @user = FactoryBot.build(:user, password: 'nominomi1')
        @count = User.count
        post :create, params: { user: { name: 'MyString',
                                        email: 'nominomi@gmail.com',
                                        password: 'foobar',
                                        password_comfirmation: 'foobar',
                                        birthday: '2019-10-29',
                                        creditcard: '123455678',
                                        creditpass: '123',
                                        postcode: '1234567',
                                        address: '東京都' } }, session: {}
      end

      it 'add new user[217]' do
        expect(@count).to eq (User.count - 1)
      end
      it 'returns a 302 response[218]' do
        expect(response).to have_http_status '302'
      end
      it 'ホーム画面に遷移すること[219]' do
        expect(response).to redirect_to root_path
      end
    end
    context '入力した値が保存されない場合' do
      before do
        @user = FactoryBot.build(:user, password: 'nominomi1')
        @count = User.count
        post :create, params: { user: { name: 'MyString',
                                        email: 'invalid',
                                        password: 'foobar',
                                        password_comfirmation: 'foobar',
                                        birthday: '2019-10-29',
                                        creditcard: '123455678',
                                        creditpass: '123',
                                        postcode: '1234567',
                                        address: '東京都' } }, session: {}
      end
      it 'returns a 200 response[2110]' do
        expect(response).to have_http_status '200'
      end
      it 'サインアップ画面に遷移すること[2111]' do
        expect(response).to render_template 'new'
      end
      it 'ホーム画面に遷移しないこと[2112]' do
        expect(response).not_to redirect_to root_path
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインユーザーである場合' do
      before do
        @user = FactoryBot.create(:user, password: 'nominomi1')
        get :edit, params: { 'id' => @user.id }, session: { 'user_id' => @user.id }
      end
      it 'returns http success[2113]' do
        expect(response).to have_http_status(:success)
      end
      it 'returns a 200 response[2114]' do
        expect(response).to have_http_status(200)
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        fake_id = 1
        get :show, params: { 'id' => fake_id }, session: {}
      end
      it 'returns a 302 response[2115]' do
        expect(response).to have_http_status(302)
      end
      it 'ログインページにリダイレクトすること[2116]' do
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'PATCH #update' do
    context 'ログインユーザーである場合' do
      before do
        @user = FactoryBot.create(:user, name: 'nomi', password: 'nominomi1')
        @params = { id: '1', user: {
          name: 'ito',
          email: 'nomi@fmail.com',
          password: 'nominomi1',
          password_comfirmation: 'nominomi1',
          birthday: '2019-10-29',
          creditcard: '123455678',
          creditpass: '124',
          postcode: '1234567',
          address: '東京都'
        } }
        patch :update, params: @params, session: { user_id: @user.id }
      end
      context '保存が成功する場合' do
        it '更新に成功すること[2117]' do
          @updated_user = User.find(1)
          expect(@updated_user.name).to eq('ito')
        end
        it '保存が成功したら、マイページ画面に遷移すること[2118]' do
          expect(response).to redirect_to '/users/1'
        end
      end

      context '保存が失敗する場合' do
        before do
          @user = FactoryBot.create(:user, name: 'nomi', password: 'nominomi1')
          @params = { id: '1', user: {
            name: 'ito',
            email: 'invalid',
            password: 'nominomi1',
            password_comfirmation: 'nominomi1',
            birthday: '2019-10-29',
            creditcard: '123455678',
            creditpass: '124',
            postcode: '1234567',
            address: '東京都'
          } }
          patch :update, params: @params, session: { user_id: @user.id }
        end
        it '保存に失敗したら200レスポンスが返ってくること[2119]' do
          expect(response).to have_http_status(:success)
        end
        it '保存に失敗したら、編集画面に遷移すること[2120]' do
          expect(response).to have_http_status(200)
        end
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        fake_id = 1
        get :show, params: { 'id' => fake_id }, session: {}
      end
      it 'ゲストユーザーならば、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe 'GET #carts' do
    context 'ログインユーザーである場合' do
      before do
        @user = FactoryBot.create(:user, id: "1")
        get :carts, params: {id: @user.id}, session: { user_id: @user.id }
      end
      it 'returns http success[2113]' do
        expect(response).to have_http_status(:success)
      end
      it 'returns a 200 response[2114]' do
        expect(response).to have_http_status(200)
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        fake_id = 1
        get :carts, params: { 'id' => fake_id }, session: {}
      end
      it 'ゲストユーザーならば、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe 'POST #create_carts' do
    context '保存に成功した場合' do
      before do
        @user = FactoryBot.create(:user, id: '1', password: 'nominomi1')
        @product = FactoryBot.create(:product, id: '1')
        @size = FactoryBot.create(:size, id: '1', size_name: 'XL')
        @count = Cart.count
        @ware = FactoryBot.create(:ware, id: '1', product_id: '1', size_id: '1')
        @params = { id: '1', product_id: @product.id.to_s, size_id: @size.id.to_s }
        post :create_carts, params: @params, session: { user_id: @user.id }
      end
      it '保存に成功したら、カート数が1増える' do
        expect(Cart.count - @count).to eq(1)
      end
      it '保存に成功したら、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it '保存が成功したら、買い物カゴ一覧画面に遷移すること' do
        expect(response).to redirect_to "/users/#{@user.id}/carts"
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        fake_id = 1
        get :carts, params: { 'id' => fake_id }, session: {}
      end
      it 'ゲストユーザーならば、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe 'DELETE #destroy_carts' do
    context 'ログインユーザーである場合' do
      before do
        @user = FactoryBot.create(:user, email: 'nomi1@gmail.com')
        cart = FactoryBot.create(:cart, id: '1')
        @params = { id: '1', cart_id: cart.id }
        @count = Cart.count
        delete :destroy_carts, params: @params, session: { user_id: @user.id }
      end
      it '削除ボタンが押されたら、カートテーブルの中の指定されたレコードが削除されること' do
        # debugger
        expect(@count - 1).to eq Cart.count
      end
      it 'レコードが削除されたら、買い物カゴ一覧画面に遷移すること' do
        expect(response).to redirect_to "/users/#{@user.id}/carts"
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        @user = FactoryBot.create(:user, email: 'nomi1@gmail.com')
        cart = FactoryBot.create(:cart, id: '1')
        @params = { id: '1', cart_id: cart.id }
        @count = Cart.count
        delete :destroy_carts, params: @params, session: { user_id: @user.id }
      end
      it 'ゲストユーザーならば、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
        expect(response).to redirect_to "/users/1/carts"
      end
    end
  end

  describe 'GET #orders' do
    context 'ログインユーザーである場合' do
      before do
        @user = FactoryBot.create(:user, id: "1")
        get :orders, params: {id: @user.id}, session: { user_id: @user.id }
      end
      it 'returns http success[2113]' do
        expect(response).to have_http_status(:success)
      end
      it 'returns a 200 response[2114]' do
        expect(response).to have_http_status(200)
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        fake_id = 1
        get :orders, params: { 'id' => fake_id }, session: {}
      end
      it 'ゲストユーザーならば、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe 'GET #orders_history' do
    context 'ログインユーザーである場合' do
      before do
        @user = FactoryBot.create(:user, id: '1')
        get :orders_history, params: { 'id' => @user.id }, session: { 'user_id' => @user.id }
      end
      it '正常なレスポンスが返ってくること[2132]' do
        expect(response).to have_http_status(:success)
      end
      it 'returns a 200 response[2133]' do
        expect(response).to have_http_status(200)
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        fake_id = 1
        get :orders_history, params: { 'id' => fake_id }, session: {}
      end
      it 'ゲストユーザーならば、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'GET #favorites' do
    context 'ログインユーザーである場合' do
      before do
        @user = FactoryBot.create(:user, id: '1')
        get :favorites, params: { 'id' => @user.id }, session: { 'user_id' => @user.id }
      end
      it '正常なレスポンスが返ってくること[2132]' do
        expect(response).to have_http_status(:success)
      end
      it 'returns a 200 response[2133]' do
        expect(response).to have_http_status(200)
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        fake_id = 1
        get :orders_history, params: { 'id' => fake_id }, session: {}
      end
      it 'ゲストユーザーならば、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'POST #create_favorites' do
    context 'ログインユーザーの場合' do
      before do
        @user = FactoryBot.create(:user, id: '1')
        @product = FactoryBot.create(:product, id: "1")
        reaction = FactoryBot.create(:reaction, id: "1", reaction_name: "お気に入り")
        @count = Favorite.count
        post :create_favorites, 
        params: { 'id' => @user.id, product_id: @product.id, reaction_id: 1 }, 
        session: { 'user_id' => @user.id }
      end
      it '保存に成功したら、お気に入り数が1増える' do
        expect(@count+1).to eq Favorite.count
      end
      it '保存に成功したら、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it '保存が成功したら、お気に入り一覧画面に遷移すること' do
        expect(response).to redirect_to "/users/#{@user.id}/favorites"
      end
    end
    context 'ゲストユーザーである場合' do
      before do
        fake_id = 1
        delete :destroy_favorites, params: { 'id' => fake_id }, session: {}
      end
      it 'ゲストユーザーならば、302レスポンスが返ってくること' do
        expect(response).to have_http_status(302)
      end
      it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe 'DELETE #destroy_favorites' do
  context 'ログインユーザーである場合' do
    before do
      @user = FactoryBot.create(:user, id: '2')
      @favorite = FactoryBot.create(:favorite, user_id: '2')
      @count = Favorite.count
      delete :destroy_favorites, 
      params: {id: @user.id, favorite_id: @favorite.id},
      session: { 'user_id' => @user.id }
    end
    it '削除ボタンが押されたら、カートテーブルの中の指定されたレコードが削除されること' do
      expect(@count - 1).to eq Favorite.count
    end
    it 'レコードが削除されたら、買い物カゴ一覧画面に遷移すること' do
      expect(response).to redirect_to "/users/#{@user.id}/favorites"
    end
  end

  context 'ゲストユーザーである場合' do
    before do
      fake_id = 1
      delete :destroy_favorites, params: { 'id' => fake_id }, session: {}
    end
    it 'ゲストユーザーならば、302レスポンスが返ってくること' do
      expect(response).to have_http_status(302)
    end
    it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
      expect(response).to redirect_to '/login'
    end
  end
end

  describe 'POST #thankyou'
  context 'ログインユーザーの場合' do
    context 'クレジットカード番号と暗証番号の組み合わせが間違っている場合' do
      before do
        @user = FactoryBot.create(:user, id: "1")
        product = FactoryBot.create(:product)
        size = FactoryBot.create(:size, id: '1', size_name: 'XL')
        @ware = FactoryBot.create(:ware, id: '1', product_id: '1', size_id: '1', amount: '1')
        
        get :thankyou,
        params: { id: @user.id, creditcard: @user.creditcard, user: { creditpass: "999" } },
        session: { user_id: @user.id }
      end
      it '買い物カゴ一覧画面に遷移すること' do
        expect(response).to redirect_to "/users/#{@user.id}/orders"
      end
    end
    context 'クレジットカード番号と暗証番号の組み合わせが正しく、
              例外処理が発生しない場合' do
      before do
        @user = FactoryBot.create(:user, id: '1', creditcard: '12345678', creditpass: '123')
        product = FactoryBot.create(:product)
        size = FactoryBot.create(:size, id: '1', size_name: 'XL')
        @ware = FactoryBot.create(:ware, id: '1', product_id: '1', size_id: '1', amount: '2')
        cart = FactoryBot.create(:cart, id: '1', user_id: @user.id, ware_id: '1')
        @order_count = Order.count
        @cart_count = Cart.count

        get :thankyou,
        params: { id: @user.id, creditcard: @user.creditcard, user: { creditpass: @user.creditpass } },
        session: { user_id: @user.id }
      end
      it "処理が行われること" do
        expect(@order_count + 1).to eq Order.count
        expect(Ware.find(1).amount).to eq @ware.amount-1
        expect(@cart_count -1).to eq Cart.count
      end
      it '例外処理がなく、トランザクション処理が成功した場合、購入履歴画面に遷移すること' do
        expect(response).to redirect_to "/users/#{@user.id}/orders_history"
      end
    end
    context '例外処理が発生した場合' do
      before do
        @user1 = FactoryBot.create(:user, id: "1", email: "nomi1@gmail.com")
        @user2 = FactoryBot.create(:user, id: "2", email: "nomi2@gmail.com")
        product = FactoryBot.create(:product)
        size = FactoryBot.create(:size, id: '1', size_name: 'XL')
        @ware = FactoryBot.create(:ware, id: '1', product_id: '1', size_id: '1', amount: '1')
        cart1 = FactoryBot.create(:cart, id: '1', user_id: @user1.id, ware_id: '1')
        cart2 = FactoryBot.create(:cart, id: '2', user_id: @user2.id, ware_id: '1')
        
        get :thankyou,
        params: { id: @user1.id, creditcard: @user1.creditcard, user: { creditpass: @user1.creditpass } },
        session: { user_id: @user1.id }

        get :thankyou,
        params: { id: @user2.id, creditcard: @user2.creditcard, user: { creditpass: @user2.creditpass } },
        session: { user_id: @user2.id }
      end
      it '買い物カゴ一覧画面に遷移すること' do
        # ActiveRecord::Base.connection.expect(:rollback_db_transaction).once
        expect(response).to redirect_to "/users/#{@user2.id}/carts"
      end
    end
  end
  context 'ゲストユーザーである場合' do
    before do
      fake_id = 1
      get :thankyou, params: { 'id' => fake_id }, session: {}
    end
    it 'ゲストユーザーならば、302レスポンスが返ってくること' do
      expect(response).to have_http_status(302)
    end
    it 'ゲストユーザーならば、ログインページにリダイレクトすること' do
      expect(response).to redirect_to '/login'
    end
  end
end
