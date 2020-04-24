require 'oystercard'

describe Oystercard do
#  subject(:oystercard) { described_class.new}
   let(:entry_station) { double :station }
   let(:exit_station) { double :station }
   let(:journey) { {entry_station: entry_station, exit_station: exit_station}}
   
      # station = "Oxford Circus"
  it 'Balance method returns 0 when initialized' do
    expect(subject.balance).to eq 0
  end
  
  # it "has an empty list of journeys" do
    
  # end

  it 'in_journey? returns false when initialized' do
    expect(subject.in_journey).to eq false
  end
  
  it "stores a journey" do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end

  describe ' #touch_in' do
    it 'in_journey becomes true when oystercard touched in' do
       subject.top_up(20)
       subject.touch_in(entry_station)
       expect(subject.in_journey).to eq true
    end
  end

    it 'checks if a card with insufficient balance is touched in' do
      expect{subject.touch_in(entry_station)}.to raise_error 'You have insufficient credit'
    end

    it 'remembers the entry station' do
      subject.top_up(10)
      expect(subject.touch_in(entry_station)).to eq entry_station
    end
    
    it 'remembers the exit station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end


  describe ' #touch_out' do
    it 'in_journey becomes false when oystercard touched out' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey).to eq false
    end

    it 'balance decreases when oystercard touched out' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect {subject.touch_out(exit_station)}.to change{subject.balance}.by -1
    end
      it 'forgets the entry station when touching out' do
        subject.top_up(20)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.entry_station).to eq nil
      end
  end

  describe ' #top_up' do

    it 'raises error if new balance exceeds limit' do
      subject.top_up(Oystercard::MAX_LIMIT)
      expect{subject.top_up(1)}.to raise_error "You have exceeded the limit of #{Oystercard::MAX_LIMIT}"
    end

    it 'top up method sets new balance to 20' do
      subject.top_up(20)
      expect(subject.balance).to eq 20
    end

    it 'increase balance (using change rspec syntax)' do
      expect {subject.top_up 20}.to change{subject.balance}.by 20
    end
  end

  describe ' #deduct' do
    it 'oystercard recieves deduct method' do
      subject.send(:deduct, 5)
    end

    it 'oystercard receives deduct method and deducts ticket' do
      expect {subject.send(:deduct, 5) }.to change{subject.balance}.by -5
    end
  end
end
