require "test_helper"

class PatientCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient_card = patient_cards(:one)
  end

  test "should get index" do
    get patient_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_patient_card_url
    assert_response :success
  end

  test "should create patient_card" do
    assert_difference("PatientCard.count") do
      post patient_cards_url, params: { patient_card: { card_number: @patient_card.card_number } }
    end

    assert_redirected_to patient_card_url(PatientCard.last)
  end

  test "should show patient_card" do
    get patient_card_url(@patient_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_patient_card_url(@patient_card)
    assert_response :success
  end

  test "should update patient_card" do
    patch patient_card_url(@patient_card), params: { patient_card: { card_number: @patient_card.card_number } }
    assert_redirected_to patient_card_url(@patient_card)
  end

  test "should destroy patient_card" do
    assert_difference("PatientCard.count", -1) do
      delete patient_card_url(@patient_card)
    end

    assert_redirected_to patient_cards_url
  end
end
