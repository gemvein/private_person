require 'spec_helper'

describe Permission do
  # Check relationships
  it { should belong_to(:permissor) }
  it { should belong_to(:permissible) }

  # Check accessible attributes
  it { should allow_mass_assignment_of(:permissible) }
  it { should allow_mass_assignment_of(:permissible_type) }
  it { should allow_mass_assignment_of(:permissible_id) }
  it { should allow_mass_assignment_of(:relationship_type) }

  # Check validations
  it { should validate_presence_of(:permissor) }
  it { should validate_presence_of(:permissible_type) }
  it { should validate_presence_of(:relationship_type) }

  describe 'Class Methods' do
    include_context 'permissions support'

    describe '.find_all_by_permissor' do
      subject { Permission.find_all_by_permissor(followed_user) }
      it { should have_exactly(8).items }
      it { should include general_permission }
      it { should include following_users_permission }
      it { should include user_followers_permission }
      it { should include follower_of_followers_permission }
      it { should include following_of_followings_permission }
      it { should include public_permission }
      it { should include none_permission }
      it { should include forbidden_permission }
    end

    describe '.find_all_by_permissible' do
      subject { Permission.find_all_by_permissible(following_page) }
      it { should eq [following_users_permission]}
    end

    describe '.find_all_by_wildcard' do
      subject { Permission.find_all_by_wildcard('Page') }
      it { should eq [general_permission] }
    end

    describe '.find_all_by_relationship_type' do
      subject { Permission.find_all_by_relationship_type('following_users') }
      it { should have_exactly(3).items }
      it { should include general_permission }
      it { should include following_users_permission }
      it { should include public_permission }
    end

    describe '.blocked' do
      subject { Permission.blocked }
      it { should have_exactly(2).items }
      it { should include none_permission }
      it { should include forbidden_permission }
    end

    describe '.legitimate' do
      subject { Permission.legitimate }
      it { should have_exactly(6).items }
      it { should include general_permission }
      it { should include following_users_permission }
      it { should include user_followers_permission }
      it { should include follower_of_followers_permission }
      it { should include following_of_followings_permission }
      it { should include public_permission }
    end

    describe '.permissible_types' do
      subject { Permission.permissible_types.sort }
      it { should be_an Array }
      it { should eq %w{following_users user_followers following_of_followings follower_of_followers public}.sort }
    end
  end

  describe 'Instance Methods' do
    include_context 'permissions support'

    describe '#existing_types' do
      subject { following_users_permission.existing_types.sort }
      it { should be_an Array }
      it { should eq %w{following_users user_followers following_of_followings follower_of_followers public}.sort }
    end
  end

end
