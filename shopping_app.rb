
# Brian Vuu Aug 2018 - DPL Shopping App Project

# -----------------------------------------------------------
# DATA / ARRAYS
# -----------------------------------------------------------

@inventory = [
	{ item: "iPhone X", price: 1199.00, qty: 100 },
	{ item: "iPhone 8", price: 699.00, qty: 100 },
	{ item: "iPhone 5S", price: 399.00, qty: 0 },
	{ item: "iPad Pro", price: 949.00, qty: 50 },
	{ item: "MacBook Pro", price: 2299.00, qty: 50 },
	{ item: "MacBook", price: 1299.00, qty: 100 },
	{ item: "iMac", price: 1099.00, qty: 25 },
	{ item: "Apple Watch", price: 599.00, qty: 25 }
]

@menu = [
	"View Inventory",
	"Make a Purchase",
	"Check My Balance",
	"Add Money",
	"Exit"
]


# -----------------------------------------------------------
# USER + WALLET
# -----------------------------------------------------------

class UserWallet
	attr_accessor :person, :cash

	def initialize(person,cash)
		@person = person 
		@cash = cash.to_f
		@balance = @cash
	end

	def credit_wallet # Load money to wallet
		load_amount = gets.to_f
		@balance = @cash + load_amount
	end

	def debit_wallet(sale_price) # Subtract money when user makes purchase
		@balance = @cash - sale_price
	end

	def user_cash
		@balance
	end

	def display_user
		puts "#{@person}"
	end

	def display_balance
		puts "#{@balance}"
	end

	def display_user_wallet
		puts "Hello #{@person}, your balance is $#{@balance}"
	end
end


	# --- Loads sample data --- #
def load_sample_data
	@user = UserWallet.new("Brian", 1000)
end

load_sample_data 

	# --- Assigns User & Wallet functions --- #
	# NOTE: adding money using user_load_money only works once.
	#       adding more than once will override any value
	#       contained in the object.. cannot figure this out... 
def user_name 
	user_name = @user.display_user
end
def user_balance 
	user_balance = @user.display_balance
end
def user_check_balance
	user_check_balance = @user.display_user_wallet
end
def	user_load_money 
	user_load_money = @user.credit_wallet
end
def user_cash
	user_cash = @user.user_cash
end


# -----------------------------------------------------------
# METHODS WHEN USER MAKES A PURCHASE 
# -----------------------------------------------------------

	# --- Retrieve item and price info 
	#     from inventory selection --- #
def get_product_info
	user_input = gets.to_i - 1
	@product_index = user_input
	@product_name = @inventory[user_input][:item]
	@product_price = @inventory[user_input][:price]
	@product_qty = @inventory[user_input][:qty]
	check_user_cash
end
	
	# --- Check if user has sufficient funds --- #
def check_user_cash
	if user_cash >= @product_price 
		check_qty_in_inventory
	else
		puts
		puts display_dots_divider
		puts "***** INSUFFICIENT FUNDS *****"
		init_small_menu
	end
end

	# --- If true, check if product is available --- #
def check_qty_in_inventory
	if @product_qty > 0
		confirm_purchase
	else 
		puts display_dots_divider
		puts "***** ITEM NOT AVAILABLE *****"
		init_small_menu
	end
end

	# --- If true, let user confirm purchase --- #
def confirm_purchase
	puts
	puts display_dots_divider
	puts 
	puts "The item you are purchasing is:"
	puts "#{@product_name}"
	puts
	puts "TOTAL: $#{@product_price}"
	puts
	puts display_dots_divider
	puts
	puts "CONFIRM PURCHASE: 1 = CANCEL, 2 = ACCEPT PURCHASE"
	puts
	user_confirmation = gets.to_i
	if user_confirmation == 1
		puts display_dots_divider
		puts "***** ORDER CANCELED *****"
		puts init_small_menu
	elsif user_confirmation == 2
		user_make_purchase
		puts
		puts display_dots_divider
		puts 
		puts "***** PURCHASE AUTHORIZED *****"
		puts "Your Balance:" 
		puts "#{user_balance}"
		puts display_dots_divider
		puts reduce_from_inventory
		puts 
	else
		puts "***** INVALID INPUT *****"
		puts init_small_menu
	end
end 

	# --- If confirm_purchase = true, 
	#     deduct money from users wallet --- # 
def user_make_purchase
	user_make_purchase = @user.debit_wallet(@product_price)
end

	# --- If confirm_purchase = true, reduce
	#     qty of purchased item from inventory --- #
	# NOTE: this gets qty from array, reduces it by 1 and
	#       stores the value in an object.. cannot figure
	#       out how to reduce directly from the array 
def reduce_from_inventory
	@product_qty = @inventory.reduce(1){ |sum, qty| sum - qty[:qty] }
	puts
	puts "***** INVENTORY UPDATED *****"
	puts
	init_small_menu
end

# -----------------------------------------------------------
# METHODS TO DISPLAY MENUS & ITEMS
# -----------------------------------------------------------

	# --- Display main menu --- #
def display_main_menu
	puts
	puts "-- MENU --"
	puts
	puts "Input a number to Navigate"
	puts
end

	# --- List menu by index --- #
def list_menu
	@menu.each_with_index do |val, indx|
		puts "#{indx+1}. #{val}"
	end
end

	# --- Display Menu for sub directories --- #
def display_small_menu
	puts display_dots_divider
	puts "INPUT A NUMBER TO NAVIGATE"
	puts "1. View Inventory 2. Make a Purchase"
	puts "3. Check My Balance 4. Add Money 5. Exit"
	puts display_dots_divider
end


	# --- List inventory by index --- #
def list_inventory
	puts
	puts "-- INVENTORY --"
	puts
	@inventory.each_with_index do |key, indx|
		puts "#{indx+1}. #{key[:item]} --- $#{key[:price]} --- #{key[:qty]} IN STOCK"
	end
end

	# --- Display info to make purchase --- #
def display_make_purchase
	puts
	puts "-- MAKE A PURCHASE --"
	puts
	puts "#{user_check_balance}"
	puts
	puts "To make a purchase," 
	puts "input the item number from the inventory list"
end

	# --- Displays user's cash balance --- #
def display_wallet
	puts
	puts "-- YOUR CASH BALANCE --"
	puts
	puts "#{user_check_balance}"
end

	# --- Displays info for user to add cash --- #
def display_add_cash
	puts
	puts "-- LOAD MONEY --"
	puts
	puts "Enter in the amount you want to add"
	puts
	puts "To cancel, enter in 0"
	puts 
end

	# --- Displays balance after user adds cash --- #
def display_money_added
	puts 
	puts display_dots_divider
	puts
	puts "*** MONEY ADDED ***"
	puts "Your Cash Balance Is: #{user_cash}"
	puts
end

	# --- Section divider --- #
def display_divider
	50.times do
		puts "."
	end
	5.times do
		puts "----------------------------------------------"
	end
end

def display_dots_divider
	puts ".............................................."
end


# -----------------------------------------------------------
# MENU / NAVIGATION. CALLS METHODS ON INPUT
# -----------------------------------------------------------

	# --- User input for Main Menu --- #
def select_menu(input)
	case input
		when 1
			display_divider
			list_inventory
			init_small_menu
		when 2
			display_divider
			list_inventory
			display_make_purchase
			get_product_info
		when 3
			display_divider
			display_wallet
			init_small_menu
		when 4
			display_divider
			display_wallet
			display_add_cash
			user_load_money
			display_money_added
			init_small_menu
		when 5
			puts '******** EXITED ********'
		else
			puts
			puts "******** INVALID SELECTION ********"
			init_menu
		end
end


# -----------------------------------------------------------
# INITIALIZE 
# -----------------------------------------------------------
	
	# --- Displays Menu and gets user input --- #
def init_menu 
	display_main_menu
	list_menu
	user_input = gets.to_i
	select_menu(user_input)
end

def init_small_menu
	display_small_menu
	user_input = gets.to_i
	select_menu(user_input)
end

	# --- Loads once on launch --- #
display_divider
init_menu

