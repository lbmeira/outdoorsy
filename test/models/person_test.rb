# frozen_string_literal: true

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test 'valid person' do
    person = Person.new(first_name: 'Peter', last_name: 'Parker', email: 'spidey@example.com')
    assert person.valid?
    assert_equal 'Peter Parker', person.full_name
  end

  test 'person record is invalid without first_name' do
    person = Person.new(last_name: 'Parker', email: 'spidey@example.com')
    refute person.valid?
    assert_equal ["can't be blank"], person.errors[:first_name]
  end

  test 'person record is invalid without last_name' do
    person = Person.new(first_name: 'Peter', email: 'spidey@example.com')
    refute person.valid?
    assert_equal ["can't be blank"], person.errors[:last_name]
  end

  test 'person record is invalid without email' do
    person = Person.new(first_name: 'Peter', last_name: 'Parker')
    refute person.valid?
    assert_equal ["can't be blank"], person.errors[:email]
  end
end
