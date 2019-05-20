require 'selenium-webdriver'
require 'rubygems'
require 'rspec/expectations'

profile = Selenium::WebDriver::Firefox::Profile.new
profile.secure_ssl = true
driver = Selenium::WebDriver::Firefox::Options

capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(accept_insecure_certs: true)
driver = ''
wait = Selenium::WebDriver::Wait.new(:timeout => 20)
key = Selenium::WebDriver::Keys
Given("Buka website") do
	driver = Selenium::WebDriver.for :firefox, desired_capabilities: capabilities
    driver.get('http://localhost:8080/')
end
Then("Mengisi data login") do
    driver.find_element(:xpath, '/html/body/div/div/main/div/nav/div[2]/div[2]/div/a').click
    el = wait.until {driver.find_element(:xpath, '/html/body/div/div/main/div/div[2]/div/div[2]/div/div[2]/form/div[1]/div/div[1]/div/input') }
    el.send_keys('owner@app.com')
    driver.find_element(:xpath, '/html/body/div/div/main/div/div[2]/div/div[2]/div/div[2]/form/div[2]/div/div[1]/div[1]/input').send_keys('password')
    driver.find_element(:xpath, '/html/body/div/div/main/div/div[2]/div/div[2]/div/div[2]/form/div[4]/button[2]').click
    sleep 5
end
Then("Mengisi data service") do
    element = wait.until {driver.find_element(:id, 'addService') }
    element.click
    driver.find_element(:xpath, '/html/body/div/div[3]/div/form/div/div[2]/div/div/div[3]/div/div/div[1]/div/input').send_keys('Mesin Ringan')
    priceField = driver.find_element(:xpath, '/html/body/div/div[3]/div/form/div/div[2]/div/div/div[4]/div/div/div[1]/div/input')
    driver.action.key_down(priceField,:control).send_keys("a").key_up(:control).key_down(:backspace).perform
    priceField.send_keys('20000')
    driver.find_element(:xpath, '/html/body/div/div[3]/div/form/div/div[3]/button[2]').click
    sleep 5
end
Then("Mengedit data service") do
    el = wait.until {driver.find_element(:xpath, '/html/body/div/div[3]/main/div/div/div[4]/main/div/div[2]/div[1]/div/div/div[2]/div[1]/div') }
    driver.action.move_to(el).perform
    driver.find_element(:xpath, '/html/body/div/div[3]/main/div/div/div[4]/main/div/div[2]/div[1]/div/div/div[2]/div[1]/p/i[1]').click
    driver.find_element(:xpath, '/html/body/div/div[3]/div/form/div/div[2]/div/div/div[3]/div/div/div[1]/div/input').send_keys(' Sekali')
    priceField = driver.find_element(:xpath, '/html/body/div/div[3]/div/form/div/div[2]/div/div/div[4]/div/div/div[1]/div/input')
    driver.action.key_down(priceField,:control).send_keys("a").key_up(:control).key_down(:backspace).perform
    priceField.send_keys('40000')
    driver.find_element(:xpath, '/html/body/div/div[3]/div/form/div/div[3]/button[2]').click
    sleep 5
end
Then("Menghapus data service") do
    el = wait.until {driver.find_element(:xpath, '/html/body/div/div[3]/main/div/div/div[4]/main/div/div[2]/div[1]/div/div/div[2]/div[1]/div') }
    driver.action.move_to(el).perform
    delete = wait.until {driver.find_element(:xpath, '/html/body/div/div[3]/main/div/div/div[4]/main/div/div[2]/div[1]/div/div/div[2]/div[1]/p/i[2]') }
    driver.action.move_to(delete).click.perform
    sleep 2
    confirm = wait.until {driver.find_element(:xpath, '/html/body/div/div[2]/div/div/div[3]/button[2]')}
    confirm.click
end
