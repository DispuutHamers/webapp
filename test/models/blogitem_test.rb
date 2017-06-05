require 'test_helper'

class BlogitemTest < ActiveSupport::TestCase
  test 'Create blog' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')
    old_count = Blogitem.count

    assert Blogitem.create(user_id: u.id, title: 'Test blogpost').save

    assert Blogitem.count == old_count + 1
  end

  test 'Add photo' do
    # How to do this?
  end

  test 'Create blog without title' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    old_count = Blogitem.count

    # No title, should not be seen in count
    Blogitem.create(user_id: u.id)

    assert Blogitem.count == old_count
    assert Blogitem.unscoped.count == old_count + 1
  end
end
