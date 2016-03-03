require 'rails_helper'

describe 'User signs in' do
  before do
    User.create(email: 'lizlemon@nbc.com', password: 'cheesyblasters')
  end

  context 'with the correct email and password' do
    it 'is signed in' do
      visit new_session_path

      fill_in 'Email', with: 'lizlemon@nbc.com'
      fill_in 'Password', with: 'cheesyblasters'
      click_on 'Sign In'

      expect(page).to have_content 'Hi, lizlemon@nbc.com'
    end
  end

  context 'with the incorrect email and password' do
    it 'is not signed in' do
      visit new_session_path

      fill_in 'Email', with: 'lizlemon@nbc.com'
      fill_in 'Password', with: 'seinfeldvision'
      click_on 'Sign In'

      expect(page.current_path).to eq '/sessions'
      expect(page).to have_content 'Your email and password do not match'
    end
  end
end
