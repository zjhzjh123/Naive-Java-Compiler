	.text
print:
	li $v0, 4
	syscall
	jr $ra

____builtin____print_int:
	li $v0, 1
	syscall
	jr $ra

println:
	li $v0, 4
	syscall
	la $a0, ____string_newline
	syscall
	jr $ra

getString:
	la $a0 ____string_buffer
	li $a1 1024
	li $v0 8
	syscall
	move $v1 $a0
	li $a1 0
Label2_Cond:
	lb $v0 ($a0)
	beqz $v0 Label2_StrSpace
	add $a1 $a1 1
	add $a0 $a0 1
	j Label2_Cond
Label2_StrSpace:
	add $a0 $a1 5
	li $v0 9
	syscall
	sw $a1 ($v0)
	add $v0 $v0 4
	move $a0 $v0
	la $a1 ____string_buffer
Label2_CopyCond:
	lb $v1 ($a1)
	beqz $v1 Label2_End
	sb $v1 ($a0)
	add $a0 $a0 1
	add $a1 $a1 1
	j Label2_CopyCond
Label2_End:
	sb $0 ($a0)
	jr $ra

getInt:
	li $v0, 5
	syscall
	jr $ra

toString:
Label12_ToString:
	move $a1 $a0
	li $a0 16
	li $v0 9
	syscall
	bnez $a1 Label12_NotZero
	lb $0 5($v0)
	li $a0 48
	sb $a0 4($v0)
	li $a0 1
	sb $a0 ($v0)
	j Label12_EndToString
Label12_NotZero:
	slt $v1 $a1 0
	add $a3 $v0 15
	sb $0 ($a3)
Label12_Cond:
	beqz $a1 Label12_EndLoop
	rem $a0 $a1 10
	div $a1 $a1 10
	beqz $v1 Label12_LoadChar
	ble $a0 0 Label12_ToNeg
	add $a0 $a0 -10
Label12_ToNeg:
	neg $a0 $a0
Label12_LoadChar:
	add $a0 $a0 48
	add $a3 $a3 -1
	sb $a0 ($a3)
	j Label12_Cond
Label12_EndLoop:
	beqz $v1 Label12_Copy
	li $a0 45
	add $a3 $a3 -1
	sb $a0 ($a3)
Label12_Copy:
	sub $v1 $v0 $a3
	add $v1 $v1 16
	sw $v1 ($v0)
	add $v1 $v0 4
Label12_CopyCond:
	lb $a0 ($a3)
	sb $a0 ($v1)
	add $a3 $a3 1
	add $v1 $v1 1
	bnez $a0 Label12_CopyCond
Label12_EndToString:
	add $v0 $v0 4
	jr $ra

size:
	lw $v0, 0($a0)
	jr $ra

length:
	lw $v0, -4($a0)
	jr $ra

ord:
	addu $a0, $a0, $a1
	lb $v0, 0($a0)
	jr $ra

substring:
	add $a2 $a2 1
	add $a1 $a0 $a1
	add $a2 $a0 $a2
	sub $v1 $a2 $a1
	add $a0 $v1 5
	li $v0 9
	syscall
	sw $v1 ($v0)
	add $v0 $v0 4
	move $a0 $v0
Label1_Loop:
	beq $a1 $a2 Label1_End
	lb $v1 ($a1)
	sb $v1 ($a0)
	add $a0 $a0 1
	add $a1 $a1 1
	j Label1_Loop
Label1_End:
	sb $0 ($a0)
	jr $ra

parseInt:
	li $v0 0
	lb $a3 ($a0)
	seq $v1 $a3 45
	add $a0 $a0 $v1
Label0_Cond:
	lb $a3 ($a0)
	blt $a3 48 Label0_Next
	bgt $a3 57 Label0_Next
	add $a3 $a3 -48
	beqz $v1 Label0_NotNeg
	neg $a3 $a3
Label0_NotNeg:
	mul $v0 $v0 10
	add $v0 $v0 $a3
	add $a0 $a0 1
	j Label0_Cond
Label0_Next:
	jr $ra

stringAdd:
	move $v1 $a0
	lw $v0 -4($a0)
	lw $a0 -4($a1)
	add $a0 $a0 $v0
	move $a2 $a0
	add $a0 $a0 5
	li $v0 9
	syscall
	sw $a2 ($v0)
	add $v0 $v0 4
	move $a0 $v0
Label5_CopyFirst:
	lb $a2 ($v1)
	beqz $a2 Label5_CopySecond
	sb $a2 ($a0)
	add $a0 $a0 1
	add $v1 $v1 1
	j Label5_CopyFirst
Label5_CopySecond:
	lb $v1 ($a1)
	beqz $v1 Label5_End
	sb $v1 ($a0)
	add $a0 $a0 1
	add $a1 $a1 1
	j Label5_CopySecond
Label5_End:
	sb $0 ($a0)
	jr $ra

stringEquals:
Label6_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label6_End
	beqz $v1 Label6_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label6_Begin
Label6_End:
	seq $v0 $v0 $v1
	jr $ra

____builtin_string____greater_than:
Label7_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label7_End
	beqz $v1 Label7_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label7_Begin
Label7_End:
	sgt $v0 $v0 $v1
	jr $ra

____builtin_string____greater_than_or_equal_to:
Label8_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label8_End
	beqz $v1 Label8_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label8_Begin
Label8_End:
	sge $v0 $v0 $v1
	jr $ra

stringLessThan:
Label9_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label9_End
	beqz $v1 Label9_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label9_Begin
Label9_End:
	slt $v0 $v0 $v1
	jr $ra

stringLessThanOrEquals:
Label10_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label10_End
	beqz $v1 Label10_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label10_Begin
Label10_End:
	sle $v0 $v0 $v1
	jr $ra

____builtin_string____not_equal_to:
Label11_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label11_End
	beqz $v1 Label11_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label11_Begin
Label11_End:
	sne $v0 $v0 $v1
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 540
	sw $s0, 476($sp)
	sw $s1, 480($sp)
	sw $s2, 484($sp)
	sw $s3, 488($sp)
	sw $s4, 492($sp)
	sw $t8, 468($sp)
	sw $t9, 472($sp)
	sw $ra, 532($sp)
label_822:
	li $t1, 99
	sw $t1, global_1
	li $t1, 100
	sw $t1, global_2
	li $t1, 101
	sw $t1, global_3
	li $t1, 102
	sw $t1, global_4
	li $t1, 0
	sw $t1, global_5
	jal getInt
	move $s4, $v0
	sw $s4, global_0
	li $t1, 1
	move $s4, $t1
	b label_824
label_824:
	lw $t1, global_0
	sle $s3, $s4, $t1
	beqz $s3, label_827
	b label_825
label_825:
	li $t1, 1
	move $s0, $t1
	b label_828
label_828:
	lw $t1, global_0
	sle $s3, $s0, $t1
	beqz $s3, label_831
	b label_829
label_829:
	li $t1, 1
	move $s2, $t1
	b label_832
label_832:
	lw $t1, global_0
	sle $s3, $s2, $t1
	beqz $s3, label_835
	b label_833
label_833:
	li $t1, 1
	move $s1, $t1
	b label_836
label_836:
	lw $t1, global_0
	sle $s3, $s1, $t1
	beqz $s3, label_839
	b label_837
label_837:
	li $t1, 1
	move $s3, $t1
	b label_840
label_840:
	lw $t1, global_0
	sle $t9, $s3, $t1
	beqz $t9, label_843
	b label_841
label_841:
	li $t1, 1
	move $t8, $t1
	b label_844
label_844:
	lw $t1, global_0
	sle $t9, $t8, $t1
	beqz $t9, label_847
	b label_845
label_845:
	sne $t9, $s4, $s0
	beqz $t9, label_852
	b label_850
label_850:
	sne $t9, $s4, $s2
	beqz $t9, label_856
	b label_854
label_854:
	sne $t9, $s4, $s1
	beqz $t9, label_860
	b label_858
label_858:
	sne $t9, $s4, $s3
	beqz $t9, label_864
	b label_862
label_862:
	sne $t9, $s4, $t8
	beqz $t9, label_868
	b label_866
label_866:
	lw $t1, global_1
	sne $t9, $s4, $t1
	beqz $t9, label_872
	b label_870
label_870:
	lw $t1, global_2
	sne $t9, $s4, $t1
	beqz $t9, label_876
	b label_874
label_874:
	lw $t1, global_3
	sne $t9, $s4, $t1
	beqz $t9, label_880
	b label_878
label_878:
	lw $t1, global_4
	sne $t9, $s4, $t1
	beqz $t9, label_884
	b label_882
label_882:
	sne $t9, $s0, $s2
	beqz $t9, label_888
	b label_886
label_886:
	sne $t9, $s0, $s1
	beqz $t9, label_892
	b label_890
label_890:
	sne $t9, $s0, $s3
	beqz $t9, label_896
	b label_894
label_894:
	sne $t9, $s0, $t8
	beqz $t9, label_900
	b label_898
label_898:
	lw $t1, global_1
	sne $t9, $s0, $t1
	beqz $t9, label_904
	b label_902
label_902:
	lw $t1, global_2
	sne $t9, $s0, $t1
	beqz $t9, label_908
	b label_906
label_906:
	lw $t1, global_3
	sne $t9, $s0, $t1
	beqz $t9, label_912
	b label_910
label_910:
	lw $t1, global_4
	sne $t9, $s0, $t1
	beqz $t9, label_916
	b label_914
label_914:
	sne $t9, $s2, $s1
	beqz $t9, label_920
	b label_918
label_918:
	sne $t9, $s2, $s3
	beqz $t9, label_924
	b label_922
label_922:
	sne $t9, $s2, $t8
	beqz $t9, label_928
	b label_926
label_926:
	lw $t1, global_1
	sne $t9, $s2, $t1
	beqz $t9, label_932
	b label_930
label_930:
	lw $t1, global_2
	sne $t9, $s2, $t1
	beqz $t9, label_936
	b label_934
label_934:
	lw $t1, global_3
	sne $t9, $s2, $t1
	beqz $t9, label_940
	b label_938
label_938:
	lw $t1, global_4
	sne $t9, $s2, $t1
	beqz $t9, label_944
	b label_942
label_942:
	sne $t9, $s1, $s3
	beqz $t9, label_948
	b label_946
label_946:
	sne $t9, $s1, $t8
	beqz $t9, label_952
	b label_950
label_950:
	lw $t1, global_1
	sne $t9, $s1, $t1
	beqz $t9, label_956
	b label_954
label_954:
	lw $t1, global_2
	sne $t9, $s1, $t1
	beqz $t9, label_960
	b label_958
label_958:
	lw $t1, global_3
	sne $t9, $s1, $t1
	beqz $t9, label_964
	b label_962
label_962:
	lw $t1, global_4
	sne $t9, $s1, $t1
	beqz $t9, label_968
	b label_966
label_966:
	sne $t9, $s3, $t8
	beqz $t9, label_972
	b label_970
label_970:
	lw $t1, global_1
	sne $t9, $s3, $t1
	beqz $t9, label_976
	b label_974
label_974:
	lw $t1, global_2
	sne $t9, $s3, $t1
	beqz $t9, label_980
	b label_978
label_978:
	lw $t1, global_3
	sne $t9, $s3, $t1
	beqz $t9, label_984
	b label_982
label_982:
	lw $t1, global_4
	sne $t9, $s3, $t1
	beqz $t9, label_988
	b label_986
label_986:
	lw $t1, global_1
	sne $t9, $t8, $t1
	beqz $t9, label_992
	b label_990
label_990:
	lw $t1, global_2
	sne $t9, $t8, $t1
	beqz $t9, label_996
	b label_994
label_994:
	lw $t1, global_3
	sne $t9, $t8, $t1
	beqz $t9, label_1000
	b label_998
label_998:
	lw $t1, global_4
	sne $t9, $t8, $t1
	beqz $t9, label_1004
	b label_1002
label_1002:
	lw $t0, global_2
	lw $t1, global_3
	sne $t9, $t0, $t1
	beqz $t9, label_1008
	b label_1006
label_1006:
	lw $t0, global_1
	lw $t1, global_4
	sne $t9, $t0, $t1
	beqz $t9, label_1008
	b label_1007
label_1007:
	li $t1, 1
	move $t9, $t1
	b label_1009
label_1008:
	li $t1, 0
	move $t9, $t1
	b label_1009
label_1009:
	beqz $t9, label_1004
	b label_1003
label_1003:
	li $t1, 1
	move $t9, $t1
	b label_1005
label_1004:
	li $t1, 0
	move $t9, $t1
	b label_1005
label_1005:
	beqz $t9, label_1000
	b label_999
label_999:
	li $t1, 1
	move $t9, $t1
	b label_1001
label_1000:
	li $t1, 0
	move $t9, $t1
	b label_1001
label_1001:
	beqz $t9, label_996
	b label_995
label_995:
	li $t1, 1
	move $t9, $t1
	b label_997
label_996:
	li $t1, 0
	move $t9, $t1
	b label_997
label_997:
	beqz $t9, label_992
	b label_991
label_991:
	li $t1, 1
	move $t9, $t1
	b label_993
label_992:
	li $t1, 0
	move $t9, $t1
	b label_993
label_993:
	beqz $t9, label_988
	b label_987
label_987:
	li $t1, 1
	move $t9, $t1
	b label_989
label_988:
	li $t1, 0
	move $t9, $t1
	b label_989
label_989:
	beqz $t9, label_984
	b label_983
label_983:
	li $t1, 1
	move $t9, $t1
	b label_985
label_984:
	li $t1, 0
	move $t9, $t1
	b label_985
label_985:
	beqz $t9, label_980
	b label_979
label_979:
	li $t1, 1
	move $t9, $t1
	b label_981
label_980:
	li $t1, 0
	move $t9, $t1
	b label_981
label_981:
	beqz $t9, label_976
	b label_975
label_975:
	li $t1, 1
	move $t9, $t1
	b label_977
label_976:
	li $t1, 0
	move $t9, $t1
	b label_977
label_977:
	beqz $t9, label_972
	b label_971
label_971:
	li $t1, 1
	move $t9, $t1
	b label_973
label_972:
	li $t1, 0
	move $t9, $t1
	b label_973
label_973:
	beqz $t9, label_968
	b label_967
label_967:
	li $t1, 1
	move $t9, $t1
	b label_969
label_968:
	li $t1, 0
	move $t9, $t1
	b label_969
label_969:
	beqz $t9, label_964
	b label_963
label_963:
	li $t1, 1
	move $t9, $t1
	b label_965
label_964:
	li $t1, 0
	move $t9, $t1
	b label_965
label_965:
	beqz $t9, label_960
	b label_959
label_959:
	li $t1, 1
	move $t9, $t1
	b label_961
label_960:
	li $t1, 0
	move $t9, $t1
	b label_961
label_961:
	beqz $t9, label_956
	b label_955
label_955:
	li $t1, 1
	move $t9, $t1
	b label_957
label_956:
	li $t1, 0
	move $t9, $t1
	b label_957
label_957:
	beqz $t9, label_952
	b label_951
label_951:
	li $t1, 1
	move $t9, $t1
	b label_953
label_952:
	li $t1, 0
	move $t9, $t1
	b label_953
label_953:
	beqz $t9, label_948
	b label_947
label_947:
	li $t1, 1
	move $t9, $t1
	b label_949
label_948:
	li $t1, 0
	move $t9, $t1
	b label_949
label_949:
	beqz $t9, label_944
	b label_943
label_943:
	li $t1, 1
	move $t9, $t1
	b label_945
label_944:
	li $t1, 0
	move $t9, $t1
	b label_945
label_945:
	beqz $t9, label_940
	b label_939
label_939:
	li $t1, 1
	move $t9, $t1
	b label_941
label_940:
	li $t1, 0
	move $t9, $t1
	b label_941
label_941:
	beqz $t9, label_936
	b label_935
label_935:
	li $t1, 1
	move $t9, $t1
	b label_937
label_936:
	li $t1, 0
	move $t9, $t1
	b label_937
label_937:
	beqz $t9, label_932
	b label_931
label_931:
	li $t1, 1
	move $t9, $t1
	b label_933
label_932:
	li $t1, 0
	move $t9, $t1
	b label_933
label_933:
	beqz $t9, label_928
	b label_927
label_927:
	li $t1, 1
	move $t9, $t1
	b label_929
label_928:
	li $t1, 0
	move $t9, $t1
	b label_929
label_929:
	beqz $t9, label_924
	b label_923
label_923:
	li $t1, 1
	move $t9, $t1
	b label_925
label_924:
	li $t1, 0
	move $t9, $t1
	b label_925
label_925:
	beqz $t9, label_920
	b label_919
label_919:
	li $t1, 1
	move $t9, $t1
	b label_921
label_920:
	li $t1, 0
	move $t9, $t1
	b label_921
label_921:
	beqz $t9, label_916
	b label_915
label_915:
	li $t1, 1
	move $t9, $t1
	b label_917
label_916:
	li $t1, 0
	move $t9, $t1
	b label_917
label_917:
	beqz $t9, label_912
	b label_911
label_911:
	li $t1, 1
	move $t9, $t1
	b label_913
label_912:
	li $t1, 0
	move $t9, $t1
	b label_913
label_913:
	beqz $t9, label_908
	b label_907
label_907:
	li $t1, 1
	move $t9, $t1
	b label_909
label_908:
	li $t1, 0
	move $t9, $t1
	b label_909
label_909:
	beqz $t9, label_904
	b label_903
label_903:
	li $t1, 1
	move $t9, $t1
	b label_905
label_904:
	li $t1, 0
	move $t9, $t1
	b label_905
label_905:
	beqz $t9, label_900
	b label_899
label_899:
	li $t1, 1
	move $t9, $t1
	b label_901
label_900:
	li $t1, 0
	move $t9, $t1
	b label_901
label_901:
	beqz $t9, label_896
	b label_895
label_895:
	li $t1, 1
	move $t9, $t1
	b label_897
label_896:
	li $t1, 0
	move $t9, $t1
	b label_897
label_897:
	beqz $t9, label_892
	b label_891
label_891:
	li $t1, 1
	move $t9, $t1
	b label_893
label_892:
	li $t1, 0
	move $t9, $t1
	b label_893
label_893:
	beqz $t9, label_888
	b label_887
label_887:
	li $t1, 1
	move $t9, $t1
	b label_889
label_888:
	li $t1, 0
	move $t9, $t1
	b label_889
label_889:
	beqz $t9, label_884
	b label_883
label_883:
	li $t1, 1
	move $t9, $t1
	b label_885
label_884:
	li $t1, 0
	move $t9, $t1
	b label_885
label_885:
	beqz $t9, label_880
	b label_879
label_879:
	li $t1, 1
	move $t9, $t1
	b label_881
label_880:
	li $t1, 0
	move $t9, $t1
	b label_881
label_881:
	beqz $t9, label_876
	b label_875
label_875:
	li $t1, 1
	move $t9, $t1
	b label_877
label_876:
	li $t1, 0
	move $t9, $t1
	b label_877
label_877:
	beqz $t9, label_872
	b label_871
label_871:
	li $t1, 1
	move $t9, $t1
	b label_873
label_872:
	li $t1, 0
	move $t9, $t1
	b label_873
label_873:
	beqz $t9, label_868
	b label_867
label_867:
	li $t1, 1
	move $t9, $t1
	b label_869
label_868:
	li $t1, 0
	move $t9, $t1
	b label_869
label_869:
	beqz $t9, label_864
	b label_863
label_863:
	li $t1, 1
	move $t9, $t1
	b label_865
label_864:
	li $t1, 0
	move $t9, $t1
	b label_865
label_865:
	beqz $t9, label_860
	b label_859
label_859:
	li $t1, 1
	move $t9, $t1
	b label_861
label_860:
	li $t1, 0
	move $t9, $t1
	b label_861
label_861:
	beqz $t9, label_856
	b label_855
label_855:
	li $t1, 1
	move $t9, $t1
	b label_857
label_856:
	li $t1, 0
	move $t9, $t1
	b label_857
label_857:
	beqz $t9, label_852
	b label_851
label_851:
	li $t1, 1
	move $t9, $t1
	b label_853
label_852:
	li $t1, 0
	move $t9, $t1
	b label_853
label_853:
	beqz $t9, label_849
	b label_848
label_848:
	lw $t1, global_5
	move $t9, $t1
	addi $t1, $t9, 1
	sw $t1, global_5
	b label_849
label_849:
label_846:
	move $t9, $t8
	addi $t8, $t9, 1
	b label_844
label_847:
label_842:
	move $s3, $s3
	addi $s3, $s3, 1
	b label_840
label_843:
label_838:
	move $s3, $s1
	addi $s1, $s3, 1
	b label_836
label_839:
label_834:
	move $s3, $s2
	addi $s2, $s3, 1
	b label_832
label_835:
label_830:
	move $s3, $s0
	addi $s0, $s3, 1
	b label_828
label_831:
label_826:
	move $s4, $s4
	addi $s4, $s4, 1
	b label_824
label_827:
	lw $a0, global_5
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	li $v0, 0
	b label_823
label_823:
	lw $ra, 532($sp)
	lw $s0, 476($sp)
	lw $s1, 480($sp)
	lw $s2, 484($sp)
	lw $s3, 488($sp)
	lw $s4, 492($sp)
	lw $t8, 468($sp)
	lw $t9, 472($sp)
	addu $sp, $sp, 540
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
global_0:
.space 4
.align 2
global_1:
.space 4
.align 2
global_2:
.space 4
.align 2
global_3:
.space 4
.align 2
global_4:
.space 4
.align 2
global_5:
.space 4
.align 2
