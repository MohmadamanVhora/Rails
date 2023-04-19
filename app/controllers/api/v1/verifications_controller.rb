module Api
  module V1
    class VerificationsController < ApplicationController
      def index; end

      def products
        @products = Product.unscoped.all.to_json
        render :index
      end

      def orders
        @orders = Order.all.to_json
        render :index
      end

      def customers
        @customers = Customer.all.to_json
        render :index
      end
    end
  end
end
