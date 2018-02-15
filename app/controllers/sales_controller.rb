class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def done
    @sale = Sale.last
  end

  def create

    cod = DateTime.now.to_i
    detail = params['sale']['detail']
    category = params['sale']['category'].to_i
    discount = params['sale']['discount'].to_i
    value = params['sale']['value'].to_i
    total = (100-discount) * value
    if !params.has_key?(:tax)
      tax = 19
      total *= 1.19
    else
      tax = 0
    end

    s = Sale.new(cod: cod, detail: detail, category: category, discount: discount, value: value, tax: tax, total: total)

    if s.save
      redirect_to sales_done_path, notice: 'el producto se ingreso correctamente'
    else
      redirect_to sales_done_path, notice: 'se ingresó mal'
    end
  end
end
