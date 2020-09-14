defmodule Test do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  alias ElixirSdetExercise
  doctest ElixirSdetExercise

  # Start hound session and destroy when tests are run
  hound_session()

  test "Loading facebook page" do
    ElixirSdetExercise.load_facebook_page
    IO.inspect page_title()
  end

  test "invalid phone number" do
    ElixirSdetExercise.load_facebook_page
    IO.inspect page_title()
    click(ElixirSdetExercise.create_new_acc_bttn)
    input_into_field(ElixirSdetExercise.first_name_el, "Sofia")
    input_into_field(ElixirSdetExercise.last_name_el, "Davis")
    input_into_field(ElixirSdetExercise.mobile_or_email_el, "5555555555")
    input_into_field(ElixirSdetExercise.new_password_el, "hgchjkkl")
    ElixirSdetExercise.select_dropdown_by_id('month', 3)
    ElixirSdetExercise.select_dropdown_by_id('day', 30)
    ElixirSdetExercise.select_dropdown_by_id('year', 1995)
    click(ElixirSdetExercise.female_bttn)
    click(ElixirSdetExercise.sign_up_bttn)
    expected = "Please enter a valid mobile number or email address."
    actual = find_element(:xpath, "//div[.='Please enter a valid mobile number or email address.']")
    try do
      assert visible_text(actual) == expected
    catch
      error ->
        take_screenshot("/media/screenshots/test_invalid_phone_number.png")
        raise error
    end
  end

  test "not eligible age to register" do
    ElixirSdetExercise.load_facebook_page
    IO.inspect page_title()
    click(ElixirSdetExercise.create_new_acc_bttn)
    input_into_field(ElixirSdetExercise.first_name_el, "Sofia")
    input_into_field(ElixirSdetExercise.last_name_el, "Davis")
    input_into_field(ElixirSdetExercise.mobile_or_email_el, "9083248377")
    input_into_field(ElixirSdetExercise.new_password_el, "sofia12345!")
    ElixirSdetExercise.select_dropdown_by_id('month', 5)
    ElixirSdetExercise.select_dropdown_by_id('day', 20)
    ElixirSdetExercise.select_dropdown_by_id('year', 2008)
    click(ElixirSdetExercise.female_bttn)
    click(ElixirSdetExercise.sign_up_bttn)
    expected = "Sorry, we are not able to process your registration."
    actual = find_element(:xpath, "//div[.='Sorry, we are not able to process your registration.']")
    try do
      assert visible_text(actual) == expected
    catch
      error ->
        take_screenshot("/media/screenshots/test_not_eligible_age_to_register.png")
        raise error
    end
  end

  test "retry on failure" do
    ElixirSdetExercise.load_facebook_page
    IO.inspect page_title()
    click(ElixirSdetExercise.create_new_acc_bttn)
    input_into_field(ElixirSdetExercise.first_name_el, "Sofia")
    input_into_field(ElixirSdetExercise.last_name_el, "Davis")
    input_into_field(ElixirSdetExercise.mobile_or_email_el, "9083248377")
    input_into_field(ElixirSdetExercise.new_password_el, "sofia12345!")
    ElixirSdetExercise.select_dropdown_by_id('month', 5)
    ElixirSdetExercise.select_dropdown_by_id('day', 20)
    ElixirSdetExercise.select_dropdown_by_id('year', 2008)
    click(ElixirSdetExercise.female_bttn)
    click(ElixirSdetExercise.sign_up_bttn)
    expected = "Sorry, we are not able to process your registration."
    actual = find_element(:xpath, "//div[.='Sorry, we are not able to process your registration.']")

    assert visible_in_element?(actual, ~r/Sorry, we are not able to process your registration./) do
      close_bttn = find_element(:css, "._8idr.img")
                   |> click()
      click(ElixirSdetExercise.create_new_acc_bttn)
      expected = "You are ineligible to register for Facebook."
      actual = find_element(:xpath, "//div[.='You are ineligible to register for Facebook.']")
      try do
        assert visible_text(actual) == expected
      catch
        error ->
          take_screenshot("/media/screenshots/test_retry_on_failure_1.png")
          raise error
      end
    else
      take_screenshot("/media/screenshots/test_retry_on_failure_2.png")
    end
  end

  test "pronoun not selected" do
    ElixirSdetExercise.load_facebook_page
    IO.inspect page_title()
    click(ElixirSdetExercise.create_new_acc_bttn)
    input_into_field(ElixirSdetExercise.first_name_el, "Alex")
    input_into_field(ElixirSdetExercise.last_name_el, "Green")
    input_into_field(ElixirSdetExercise.mobile_or_email_el, "9083248377")
    input_into_field(ElixirSdetExercise.new_password_el, "green12345!")
    ElixirSdetExercise.select_dropdown_by_id('month', 4)
    ElixirSdetExercise.select_dropdown_by_id('day', 15)
    ElixirSdetExercise.select_dropdown_by_id('year', 1993)
    click(ElixirSdetExercise.custom_bttn)
    ElixirSdetExercise.select_dropdown_by_class("._7-16._5dba", 6)
    click(ElixirSdetExercise.sign_up_bttn)
    expected = "Select your pronoun"
    actual = find_element(:xpath, "//div[.='Select your pronoun']")
    try do
      assert visible_text(actual) == expected
    catch
      error ->
        take_screenshot("/media/screenshots/test_pronoun_not_selected.png")
        raise error
    end
  end


  #extra credit task
  test "different login page is loaded with valid email invalid password" do
    ElixirSdetExercise.load_facebook_page
    IO.inspect page_title()
    page_title = page_title()
    input_into_field(ElixirSdetExercise.email_loginpage_el, "alexgreen@gmail.com")
    input_into_field(ElixirSdetExercise.pswd_loginpage_el, "1234567")
    click(ElixirSdetExercise.login_bttn)
    refute page_title() == page_title
  end

# More to be implemented
      # Symbols in name
      # Unacceptable long name
      # Doesn't allow to proceed without:
                              # -last name
                              # -first name
                              # -gender
                              # -email/phone number
                              # -DOB
                              # -no values entered
      # Cannot proceed with short password
      # Cannot proceed with same password as email/phone number
      # Cannot proceed with empty password field

end

