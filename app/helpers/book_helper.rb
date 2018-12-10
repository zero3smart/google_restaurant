module BookHelper
    def book_time(restaurant_name, reserve_date)
        r_date_obj = Date.strptime(reserve_date, "%m/%d/%Y")
        current_year = Date.today.year()

        year_diff = current_year - r_date_obj.year()

        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        Selenium::WebDriver::Chrome.driver_path=Dir.pwd + "/bin/chromedriver"
        driver = Selenium::WebDriver.for :chrome, options: options

        driver.get "https://www.google.com/maps/@42.3020447,-71.3883247,17z"
        # driver.get "https://www.google.com/maps/reserve/v/dine/c/TxwxStfp_yo?source=pa&hl=en-US&gei=tzoIXMzjHNLS8wXyoYuoDQ&sourceurl=https://www.google.com/maps/preview/entity?authuser%3D0%26hl%3Den%26gl%3Dus%26pb%3D!1m14!1s0x89e3889885a26111:0xa7767b093a1ab17c!3m12!1m3!1d2640.8196502614906!2d-76.99751528255612!3d38.880642099999996!2m3!1f0!2f0!3f0!3m2!1i510!2i653!4f13.1!12m3!2m2!1i392!2i106!13m57!2m2!1i203!2i100!3m2!2i4!5b1!6m6!1m2!1i86!2i86!1m2!1i408!2i200!7m42!1m3!1e1!2b0!3e3!1m3!1e2!2b1!3e2!1m3!1e2!2b0!3e3!1m3!1e3!2b0!3e3!1m3!1e8!2b0!3e3!1m3!1e3!2b1!3e2!1m3!1e9!2b1!3e2!1m3!1e10!2b0!3e3!1m3!1e10!2b1!3e2!1m3!1e10!2b0!3e4!2b1!4b1!9b0!14m5!1s!4m1!2i5361!7e81!12e3!15m21!2b1!5m4!2b1!3b1!5b1!6b1!10m1!8e3!14m1!3b1!17b1!24b1!25b1!26b1!30m1!2b1!36b1!43b1!52b1!56m1!1b1!21m0!22m1!1e81!29m0!30m1!3b1%26q%3DBlue%2BDalia%2BRestaurant%2B%2526%2BTequila%2BBar,%2BWorcester%2BStreet,%2BNatick,%2BMA"

        element = driver.find_element :id => "searchboxinput"
        element.send_keys restaurant_name

        element = driver.find_element(:id, "searchbox-searchbutton")
        element.click()

        # loop do
            element = driver.find_elements(:class, "internal-place-actions-link")
            if element.any?
                element[0].click()
                # break
            end
        # end

        sleep 10

        # @driver.find_element(:css, "#select_a_boundary.dataset_select2")
        # @driver.find_element(:css, "div[id=select_a_boundary][class=dataset_select2]")
        # arrow = driver.find_element_by_xpath('//div[@id="abc" and @class="xyz"]')

        f = File.new('out.txt', 'w')
        f.write(driver.page_source)
        f.close

        # element = driver.find_element(:css, ".bKA5T")
        # element.click()

        # sleep 1

        # byebug

        # if year_diff > 0
        #     year_diff.abs.times do
        #         element = driver.find_element(:css, ".Ny2ATe div[role=button]")

        #         if element.attribute('aria-label') == 'previous month'
        #             element.click()
        #             sleep 1
        #         end
        #     end
        # elsif year_diff < 0
        #     year_diff.abs.times do
        #         element = driver.find_element(:css, ".Ny2ATe.m7vaFf div[role=button]")

        #         if element.attribute('aria-label') == 'next month'
        #             element.click()
        #             sleep 1
        #         end
        #     end
        # end

        # elements = driver.find_elements(:css, ".ekHVrb.Ny2ATe div[role=button]")

        # elements.each do |element|
        #     if element.attribute('aria-label') == r_date_obj.day().to_s
        #         element.click()
        #         puts "click"
        #         sleep 1
        #         break
        #     end
        # end

        page_source = driver.page_source
        book_time = []
        frag = Nokogiri::HTML(page_source)
        frag.css('div.uSq8k div[role="button"]').each do |el|
            if el.text.downcase.include? "pm" or el.text.downcase.include? "am"
                book_time << el.text
            end
        end

        driver.quit

        book_time
    end
end