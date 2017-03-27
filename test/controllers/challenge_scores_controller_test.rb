require 'test_helper'

class ChallengeScoresControllerTest < ActionController::TestCase
  setup do
    @challenge_score = challenge_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:challenge_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create challenge_score" do
    assert_difference('ChallengeScore.count') do
      post :create, challenge_score: { challenge_id: @challenge_score.challenge_id, challenge_time: @challenge_score.challenge_time, url: @challenge_score.url, user_id: @challenge_score.user_id }
    end

    assert_redirected_to challenge_score_path(assigns(:challenge_score))
  end

  test "should show challenge_score" do
    get :show, id: @challenge_score
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @challenge_score
    assert_response :success
  end

  test "should update challenge_score" do
    patch :update, id: @challenge_score, challenge_score: { challenge_id: @challenge_score.challenge_id, challenge_time: @challenge_score.challenge_time, url: @challenge_score.url, user_id: @challenge_score.user_id }
    assert_redirected_to challenge_score_path(assigns(:challenge_score))
  end

  test "should destroy challenge_score" do
    assert_difference('ChallengeScore.count', -1) do
      delete :destroy, id: @challenge_score
    end

    assert_redirected_to challenge_scores_path
  end
end
