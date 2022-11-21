require 'rails_helper'

RSpec.describe 'Index', type: :system do

  before do
    driven_by(:selenium_chrome_headless)
  end
  
  it 'shows the correct title' do
    visit games_path
    expect(page).to have_content('Word Fwends')
  end
end