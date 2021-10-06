require 'test_helper'

class BlogitemTest < ActiveSupport::TestCase
  test 'Create blog' do
    u = users(:one)

    old_count = Blogitem.count

    assert Blogitem.create(user_id: u.id, title: 'Test blogpost').save

    assert Blogitem.count == old_count + 1
  end
end
