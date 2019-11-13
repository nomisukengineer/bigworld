require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
    include ApplicationHelper

    describe "full_title(page_title = '')" do
        context "ページタイトルの指定がある場合" do
            before do
                @page_title = 'タイトル'
            end
            it "タイトル｜Bigwprldがタイトルになる" do
                expect(full_title(@page_title)).to eq "タイトル | Bigworld"
            end
        end
        context "ページタイトルの指定がない場合" do
            it "Bigworldがタイトルになる" do
                expect(full_title).to eq "Bigworld"
            end
        end
    end
end