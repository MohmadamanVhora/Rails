module Api
  module V1
    class VerificationsController < ApplicationController
      def index; end

      def products
        @products = Product.unscoped.all
        render json: @products
      end

      def orders
        @orders = Order.all
        render json: @orders
      end

      def customers
        @customers = Customer.all
        render json: @customers
      end
    end
  end
end
