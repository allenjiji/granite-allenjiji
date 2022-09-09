# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  # embed new test cases here...
  def test_user_should_not_be_valid_and_saved_without_name
    @user.name = ""
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Name can't be blank"
  end

  def test_name_should_be_of_valid_length
    @user.name = "a" * (User::MAX_NAME_LENGTH + 1)
    assert @user.invalid?
  end

  def test_user_should_not_be_saved_without_password
    @user.password = nil
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Password can't be blank"
  end

  def test_user_should_not_be_saved_without_password_confirmation
    @user.password_confirmation = nil
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Password confirmation can't be blank"
  end

  def test_user_should_have_matching_password_and_password_confirmation
    @user.password_confirmation = "#{@user.password}-random"
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Password confirmation doesn't match Password"
  end

  def test_users_should_have_unique_auth_token
    @user.save!
    second_user = create(:user)

    assert_not_same @user.authentication_token,
      second_user.authentication_token
  end

  # def test_tasks_created_by_user_are_deleted_when_user_is_deleted
  #   task_owner = build(:user)
  #   create(:task, assigned_user: @user, task_owner: task_owner)

  #   assert_difference "Task.count", -1 do
  #     task_owner.destroy
  #   end
  # end

  # def test_tasks_are_assigned_back_to_task_owners_before_assigned_user_is_destroyed
  #   task_owner = build(:user)
  #   task = create(:task, assigned_user: @user, task_owner: task_owner)

  #   assert_equal task.assigned_user_id, @user.id
  #   @user.destroy
  #   assert_equal task.reload.assigned_user_id, task_owner.id
  # end

  def test_preference_created_is_valid
    @user.save
    assert @user.preference.valid?
  end

  def test_notification_delivery_hour_uses_default_value
    @user.save
    assert_equal @user.preference.notification_delivery_hour, Constants::DEFAULT_NOTIFICATION_DELIVERY_HOUR
  end
end
