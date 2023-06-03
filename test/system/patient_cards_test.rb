require "application_system_test_case"

class PatientCardsTest < ApplicationSystemTestCase
  setup do
    @patient_card = patient_cards(:one)
  end

  test "visiting the index" do
    visit patient_cards_url
    assert_selector "h1", text: "Patient cards"
  end

  test "should create patient card" do
    visit patient_cards_url
    click_on "New patient card"

    fill_in "Card number", with: @patient_card.card_number
    click_on "Create Patient card"

    assert_text "Patient card was successfully created"
    click_on "Back"
  end

  test "should update Patient card" do
    visit patient_card_url(@patient_card)
    click_on "Edit this patient card", match: :first

    fill_in "Card number", with: @patient_card.card_number
    click_on "Update Patient card"

    assert_text "Patient card was successfully updated"
    click_on "Back"
  end

  test "should destroy Patient card" do
    visit patient_card_url(@patient_card)
    click_on "Destroy this patient card", match: :first

    assert_text "Patient card was successfully destroyed"
  end
end
