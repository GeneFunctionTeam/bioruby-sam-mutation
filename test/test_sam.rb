require 'helper'
class SAMTest < Test::Unit::TestCase
	def test_split_types
		sam = Bio::Alignment::SAM.new("DKNQZ:00025:00303       0       5       112767204       37      60M1D7M2I6M     *       0       0       GCAGTAATTTCCCTGGAGTAAAACTGCGGTCAAAAATGTCCCTCCGTTCTTATGGAAGCCGGAAGGAAGTCTGTA     CCCCCC@CE>CC<CC@CB;;;;.;;;;;AC;::::+:92A:=CCAEE=?>;=:@<B?:<6<*/*/*/*/911112     XT:A:U NM:i:3 X0:i:1 X1:i:0 XM:i:3 XO:i:1 XG:i:1 MD:Z:60^G13")
		assert(sam.qname.is_a? String)
		assert(sam.flag.is_a? String)
		assert(sam.rname.is_a? String)
		assert(sam.pos.is_a? Integer)
		assert(sam.mapq.is_a? Integer)
		assert(sam.cigar.is_a? String)
		assert(sam.mrnm.is_a?(String) || sam.mrnm.nil?)
		assert(sam.mpos.is_a?(Integer) || sam.mpos.nil?)
		assert(sam.isize.is_a?(Integer) || sam.isize.nil?)
		assert(sam.seq.instance_of? Bio::Sequence::NA)
		assert(sam.qual.is_a? String)
		assert(sam.tags.is_a? Hash)

	end
	def test_split
		sam = Bio::Alignment::SAM.new("DKNQZ:00025:00303       0       5       112767204       37      60M1D7M2I6M     *       0       0       GCAGTAATTTCCCTGGAGTAAAACTGCGGTCAAAAATGTCCCTCCGTTCTTATGGAAGCCGGAAGGAAGTCTGTA     CCCCCC@CE>CC<CC@CB;;;;.;;;;;AC;::::+:92A:=CCAEE=?>;=:@<B?:<6<*/*/*/*/911112     XT:A:U  NM:i:3  X0:i:1  X1:i:0  XM:i:3  XO:i:1  XG:i:1  MD:Z:60^G13")
		assert_equal(sam.qname,"DKNQZ:00025:00303","ID not as expected")
		assert_equal(sam.flag,"0","Flag not as expected")
		assert_equal(sam.rname,"5","Chr not as expected")
		assert_equal(sam.pos,112767204,"Position not as expected")
		assert_equal(sam.mapq,37,"Quality not as expected")
		assert_equal(sam.cigar,"60M1D7M2I6M","CIGAR not as expected")
		assert_equal(sam.mrnm,nil,"Mate chr not as expected [* -> nil]")
		assert_equal(sam.mpos,nil,"Mate pos not as expected [0 -> nil]")
		assert_equal(sam.isize,nil,"Insertion size not as expected [0 -> nil]")
		assert_equal(sam.seq,Bio::Sequence::NA.new("GCAGTAATTTCCCTGGAGTAAAACTGCGGTCAAAAATGTCCCTCCGTTCTTATGGAAGCCGGAAGGAAGTCTGTA"),"Sequence not as expected")
		assert_equal(sam.qual,"CCCCCC@CE>CC<CC@CB;;;;.;;;;;AC;::::+:92A:=CCAEE=?>;=:@<B?:<6<*/*/*/*/911112","Base quality string not as expected")
 assert_equal(sam.tags,{:unsplit_tags => "XT:A:U NM:i:3 X0:i:1 X1:i:0 XM:i:3 XO:i:1 XG:i:1 MD:Z:60^G13", "XT:A" => "U", "NM:i" => "3", "X0:i" => "1", "X1:i" => "0", "XM:i" => "3", "XO:i" => "1","XG:i" => "1", "MD:Z" =>"60^G13"})

	end

	def test_aliases
		sam = Bio::Alignment::SAM.new("DKNQZ:00025:00303       0       5       112767204       37      60M1D7M2I6M     *       0       0       GCAGTAATTTCCCTGGAGTAAAACTGCGGTCAAAAATGTCCCTCCGTTCTTATGGAAGCCGGAAGGAAGTCTGTA     CCCCCC@CE>CC<CC@CB;;;;.;;;;;AC;::::+:92A:=CCAEE=?>;=:@<B?:<6<*/*/*/*/911112     XT:A:U  NM:i:3  X0:i:1  X1:i:0  XM:i:3  XO:i:1  XG:i:1  MD:Z:60^G13")
		assert_equal(sam.chr,sam.rname)
		assert_equal(sam.tags,sam.opt)
	end

end


