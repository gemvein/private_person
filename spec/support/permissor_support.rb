shared_context 'permissor support' do
  let!(:public_user) { FactoryGirl.create(:user) }
  let!(:private_user) { FactoryGirl.create(:user) }

  let!(:public_user_page) { FactoryGirl.create(:page, :user => public_user)}
  let!(:private_user_page) { FactoryGirl.create(:page, :user => private_user)}

  before do
    public_user.wildcard_permit! 'public', 'Page'
    private_user.wildcard_permit! 'none', 'Page'
  end
end