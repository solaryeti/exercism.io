require './test/integration_helper'

class CohortTest < Minitest::Test
  include DBCleaner

  def test_team_members_and_managers
    alice = User.create username: 'alice'
    bob = User.create username: 'bob'
    charlie = User.create username: 'charlie'
    dave = User.create username: 'dave', completed: {'ruby' => ['cake']}
    eve = User.create username: 'eve'

    Submission.create(language: 'ruby', slug: 'cake', code: 'CODE', user: charlie)

    Team.create(slug: 'team1', members: [bob, charlie], creator: alice)
    Team.create(slug: 'team2', members: [bob, dave, eve], creator: alice)

    assert_equal Set.new, Cohort.for(alice).users

    exercise = Exercise.new('ruby', 'cake')

    cohort = Cohort.for(bob)
    assert_equal %w(charlie dave eve), cohort.members.map(&:username)
    assert_equal ['alice'], cohort.managers.map(&:username)
    assert_equal %w(alice charlie dave eve), cohort.users.map(&:username).sort
    assert_equal %w(alice charlie dave), cohort.sees(exercise).map(&:username)
  end

end

