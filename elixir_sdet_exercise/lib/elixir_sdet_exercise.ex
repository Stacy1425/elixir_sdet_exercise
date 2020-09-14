defmodule ElixirSdetExercise do
  use Hound.Helpers
  @moduledoc """
Provides reusable methods to open facebook page and do negative testings on the account creation feature.
"""

  @doc """
  Stores reusable elements.
"""
  def assign_elements do
    create_new_acc_bttn = find_element(:id, "u_0_2")
    first_name_el = find_element(:name, "firstname")
    last_name_el = find_element(:name, "lastname")
    mobile_or_email_el = find_element(:name, "reg_email__")
    reenter_email_el = find_element(:name, "reg_email_confirmation__")
    new_password_el = find_element(:id, "password_step_input")

    female_bttn = find_element(:xpath, "//input[@class='_8esa'])[1]")
    male_bttn = find_element(:xpath, "//input[@class='_8esa'])[2]")

    custom_bttn = find_element(:xpath, "//input[@class='_8esa'])[3]")
    pronoun_bttn = find_element(:name, "preferred_pronoun")

    email_loginpage_el = find_element(:id, "email")
    pswd_loginpage_el = find_element(:id, "pass")
    login_bttn = find_element(:name, "login")
    sign_up_bttn = find_element(:id, "u_1_s")
  end

  @url "https://www.facebook.com/"

  @doc """
   Select method for dropdown elements with id locator

    ## Examples
        select_dropdown_by_id('month', 3)
        ["march"]

"""
  def select_dropdown_by_id(drop_down_id, option) do
    find_element(:id, "#{drop_down_id} option[value='#{option}']") |> click()
  end
  @doc """
     Returns a value from dropdown using class locator
  """
  def select_dropdown_by_css(drop_down_css, option) do
    find_element(:css, "{drop_down_css} option[value='#{option}']") |> click()
  end

  @doc """
  Loading facebook page
  """
  def load_facebook_page do
    maximize_window(current_window_handle())
    navigate_to(@url)
  end
  end
