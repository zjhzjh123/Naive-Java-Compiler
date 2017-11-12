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
label_958:
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
	move $s0, $t1
	b label_960
label_960:
	lw $t1, global_0
	sle $s4, $s0, $t1
	beqz $s4, label_963
	b label_961
label_961:
	li $t1, 1
	move $s3, $t1
	b label_964
label_964:
	lw $t1, global_0
	sle $s4, $s3, $t1
	beqz $s4, label_967
	b label_965
label_965:
	li $t1, 1
	move $s4, $t1
	b label_968
label_968:
	lw $t1, global_0
	sle $s2, $s4, $t1
	beqz $s2, label_971
	b label_969
label_969:
	li $t1, 1
	move $s2, $t1
	b label_972
label_972:
	lw $t1, global_0
	sle $s1, $s2, $t1
	beqz $s1, label_975
	b label_973
label_973:
	li $t1, 1
	move $s1, $t1
	b label_976
label_976:
	lw $t1, global_0
	sle $t9, $s1, $t1
	beqz $t9, label_979
	b label_977
label_977:
	li $t1, 1
	move $t9, $t1
	b label_980
label_980:
	lw $t1, global_0
	sle $t8, $t9, $t1
	beqz $t8, label_983
	b label_981
label_981:
	sne $t8, $s0, $s3
	beqz $t8, label_988
	b label_986
label_986:
	sne $t8, $s0, $s4
	beqz $t8, label_992
	b label_990
label_990:
	sne $t8, $s0, $s2
	beqz $t8, label_996
	b label_994
label_994:
	sne $t8, $s0, $s1
	beqz $t8, label_1000
	b label_998
label_998:
	sne $t8, $s0, $t9
	beqz $t8, label_1004
	b label_1002
label_1002:
	lw $t1, global_1
	sne $t8, $s0, $t1
	beqz $t8, label_1008
	b label_1006
label_1006:
	lw $t1, global_2
	sne $t8, $s0, $t1
	beqz $t8, label_1012
	b label_1010
label_1010:
	lw $t1, global_3
	sne $t8, $s0, $t1
	beqz $t8, label_1016
	b label_1014
label_1014:
	lw $t1, global_4
	sne $t8, $s0, $t1
	beqz $t8, label_1020
	b label_1018
label_1018:
	sne $t8, $s3, $s4
	beqz $t8, label_1024
	b label_1022
label_1022:
	sne $t8, $s3, $s2
	beqz $t8, label_1028
	b label_1026
label_1026:
	sne $t8, $s3, $s1
	beqz $t8, label_1032
	b label_1030
label_1030:
	sne $t8, $s3, $t9
	beqz $t8, label_1036
	b label_1034
label_1034:
	lw $t1, global_1
	sne $t8, $s3, $t1
	beqz $t8, label_1040
	b label_1038
label_1038:
	lw $t1, global_2
	sne $t8, $s3, $t1
	beqz $t8, label_1044
	b label_1042
label_1042:
	lw $t1, global_3
	sne $t8, $s3, $t1
	beqz $t8, label_1048
	b label_1046
label_1046:
	lw $t1, global_4
	sne $t8, $s3, $t1
	beqz $t8, label_1052
	b label_1050
label_1050:
	sne $t8, $s4, $s2
	beqz $t8, label_1056
	b label_1054
label_1054:
	sne $t8, $s4, $s1
	beqz $t8, label_1060
	b label_1058
label_1058:
	sne $t8, $s4, $t9
	beqz $t8, label_1064
	b label_1062
label_1062:
	lw $t1, global_1
	sne $t8, $s4, $t1
	beqz $t8, label_1068
	b label_1066
label_1066:
	lw $t1, global_2
	sne $t8, $s4, $t1
	beqz $t8, label_1072
	b label_1070
label_1070:
	lw $t1, global_3
	sne $t8, $s4, $t1
	beqz $t8, label_1076
	b label_1074
label_1074:
	lw $t1, global_4
	sne $t8, $s4, $t1
	beqz $t8, label_1080
	b label_1078
label_1078:
	sne $t8, $s2, $s1
	beqz $t8, label_1084
	b label_1082
label_1082:
	sne $t8, $s2, $t9
	beqz $t8, label_1088
	b label_1086
label_1086:
	lw $t1, global_1
	sne $t8, $s2, $t1
	beqz $t8, label_1092
	b label_1090
label_1090:
	lw $t1, global_2
	sne $t8, $s2, $t1
	beqz $t8, label_1096
	b label_1094
label_1094:
	lw $t1, global_3
	sne $t8, $s2, $t1
	beqz $t8, label_1100
	b label_1098
label_1098:
	lw $t1, global_4
	sne $t8, $s2, $t1
	beqz $t8, label_1104
	b label_1102
label_1102:
	sne $t8, $s1, $t9
	beqz $t8, label_1108
	b label_1106
label_1106:
	lw $t1, global_1
	sne $t8, $s1, $t1
	beqz $t8, label_1112
	b label_1110
label_1110:
	lw $t1, global_2
	sne $t8, $s1, $t1
	beqz $t8, label_1116
	b label_1114
label_1114:
	lw $t1, global_3
	sne $t8, $s1, $t1
	beqz $t8, label_1120
	b label_1118
label_1118:
	lw $t1, global_4
	sne $t8, $s1, $t1
	beqz $t8, label_1124
	b label_1122
label_1122:
	lw $t1, global_1
	sne $t8, $t9, $t1
	beqz $t8, label_1128
	b label_1126
label_1126:
	lw $t1, global_2
	sne $t8, $t9, $t1
	beqz $t8, label_1132
	b label_1130
label_1130:
	lw $t1, global_3
	sne $t8, $t9, $t1
	beqz $t8, label_1136
	b label_1134
label_1134:
	lw $t1, global_4
	sne $t8, $t9, $t1
	beqz $t8, label_1140
	b label_1138
label_1138:
	lw $t0, global_2
	lw $t1, global_3
	sne $t8, $t0, $t1
	beqz $t8, label_1144
	b label_1142
label_1142:
	lw $t0, global_1
	lw $t1, global_4
	sne $t8, $t0, $t1
	beqz $t8, label_1144
	b label_1143
label_1143:
	li $t1, 1
	move $t8, $t1
	b label_1145
label_1144:
	li $t1, 0
	move $t8, $t1
	b label_1145
label_1145:
	beqz $t8, label_1140
	b label_1139
label_1139:
	li $t1, 1
	move $t8, $t1
	b label_1141
label_1140:
	li $t1, 0
	move $t8, $t1
	b label_1141
label_1141:
	beqz $t8, label_1136
	b label_1135
label_1135:
	li $t1, 1
	move $t8, $t1
	b label_1137
label_1136:
	li $t1, 0
	move $t8, $t1
	b label_1137
label_1137:
	beqz $t8, label_1132
	b label_1131
label_1131:
	li $t1, 1
	move $t8, $t1
	b label_1133
label_1132:
	li $t1, 0
	move $t8, $t1
	b label_1133
label_1133:
	beqz $t8, label_1128
	b label_1127
label_1127:
	li $t1, 1
	move $t8, $t1
	b label_1129
label_1128:
	li $t1, 0
	move $t8, $t1
	b label_1129
label_1129:
	beqz $t8, label_1124
	b label_1123
label_1123:
	li $t1, 1
	move $t8, $t1
	b label_1125
label_1124:
	li $t1, 0
	move $t8, $t1
	b label_1125
label_1125:
	beqz $t8, label_1120
	b label_1119
label_1119:
	li $t1, 1
	move $t8, $t1
	b label_1121
label_1120:
	li $t1, 0
	move $t8, $t1
	b label_1121
label_1121:
	beqz $t8, label_1116
	b label_1115
label_1115:
	li $t1, 1
	move $t8, $t1
	b label_1117
label_1116:
	li $t1, 0
	move $t8, $t1
	b label_1117
label_1117:
	beqz $t8, label_1112
	b label_1111
label_1111:
	li $t1, 1
	move $t8, $t1
	b label_1113
label_1112:
	li $t1, 0
	move $t8, $t1
	b label_1113
label_1113:
	beqz $t8, label_1108
	b label_1107
label_1107:
	li $t1, 1
	move $t8, $t1
	b label_1109
label_1108:
	li $t1, 0
	move $t8, $t1
	b label_1109
label_1109:
	beqz $t8, label_1104
	b label_1103
label_1103:
	li $t1, 1
	move $t8, $t1
	b label_1105
label_1104:
	li $t1, 0
	move $t8, $t1
	b label_1105
label_1105:
	beqz $t8, label_1100
	b label_1099
label_1099:
	li $t1, 1
	move $t8, $t1
	b label_1101
label_1100:
	li $t1, 0
	move $t8, $t1
	b label_1101
label_1101:
	beqz $t8, label_1096
	b label_1095
label_1095:
	li $t1, 1
	move $t8, $t1
	b label_1097
label_1096:
	li $t1, 0
	move $t8, $t1
	b label_1097
label_1097:
	beqz $t8, label_1092
	b label_1091
label_1091:
	li $t1, 1
	move $t8, $t1
	b label_1093
label_1092:
	li $t1, 0
	move $t8, $t1
	b label_1093
label_1093:
	beqz $t8, label_1088
	b label_1087
label_1087:
	li $t1, 1
	move $t8, $t1
	b label_1089
label_1088:
	li $t1, 0
	move $t8, $t1
	b label_1089
label_1089:
	beqz $t8, label_1084
	b label_1083
label_1083:
	li $t1, 1
	move $t8, $t1
	b label_1085
label_1084:
	li $t1, 0
	move $t8, $t1
	b label_1085
label_1085:
	beqz $t8, label_1080
	b label_1079
label_1079:
	li $t1, 1
	move $t8, $t1
	b label_1081
label_1080:
	li $t1, 0
	move $t8, $t1
	b label_1081
label_1081:
	beqz $t8, label_1076
	b label_1075
label_1075:
	li $t1, 1
	move $t8, $t1
	b label_1077
label_1076:
	li $t1, 0
	move $t8, $t1
	b label_1077
label_1077:
	beqz $t8, label_1072
	b label_1071
label_1071:
	li $t1, 1
	move $t8, $t1
	b label_1073
label_1072:
	li $t1, 0
	move $t8, $t1
	b label_1073
label_1073:
	beqz $t8, label_1068
	b label_1067
label_1067:
	li $t1, 1
	move $t8, $t1
	b label_1069
label_1068:
	li $t1, 0
	move $t8, $t1
	b label_1069
label_1069:
	beqz $t8, label_1064
	b label_1063
label_1063:
	li $t1, 1
	move $t8, $t1
	b label_1065
label_1064:
	li $t1, 0
	move $t8, $t1
	b label_1065
label_1065:
	beqz $t8, label_1060
	b label_1059
label_1059:
	li $t1, 1
	move $t8, $t1
	b label_1061
label_1060:
	li $t1, 0
	move $t8, $t1
	b label_1061
label_1061:
	beqz $t8, label_1056
	b label_1055
label_1055:
	li $t1, 1
	move $t8, $t1
	b label_1057
label_1056:
	li $t1, 0
	move $t8, $t1
	b label_1057
label_1057:
	beqz $t8, label_1052
	b label_1051
label_1051:
	li $t1, 1
	move $t8, $t1
	b label_1053
label_1052:
	li $t1, 0
	move $t8, $t1
	b label_1053
label_1053:
	beqz $t8, label_1048
	b label_1047
label_1047:
	li $t1, 1
	move $t8, $t1
	b label_1049
label_1048:
	li $t1, 0
	move $t8, $t1
	b label_1049
label_1049:
	beqz $t8, label_1044
	b label_1043
label_1043:
	li $t1, 1
	move $t8, $t1
	b label_1045
label_1044:
	li $t1, 0
	move $t8, $t1
	b label_1045
label_1045:
	beqz $t8, label_1040
	b label_1039
label_1039:
	li $t1, 1
	move $t8, $t1
	b label_1041
label_1040:
	li $t1, 0
	move $t8, $t1
	b label_1041
label_1041:
	beqz $t8, label_1036
	b label_1035
label_1035:
	li $t1, 1
	move $t8, $t1
	b label_1037
label_1036:
	li $t1, 0
	move $t8, $t1
	b label_1037
label_1037:
	beqz $t8, label_1032
	b label_1031
label_1031:
	li $t1, 1
	move $t8, $t1
	b label_1033
label_1032:
	li $t1, 0
	move $t8, $t1
	b label_1033
label_1033:
	beqz $t8, label_1028
	b label_1027
label_1027:
	li $t1, 1
	move $t8, $t1
	b label_1029
label_1028:
	li $t1, 0
	move $t8, $t1
	b label_1029
label_1029:
	beqz $t8, label_1024
	b label_1023
label_1023:
	li $t1, 1
	move $t8, $t1
	b label_1025
label_1024:
	li $t1, 0
	move $t8, $t1
	b label_1025
label_1025:
	beqz $t8, label_1020
	b label_1019
label_1019:
	li $t1, 1
	move $t8, $t1
	b label_1021
label_1020:
	li $t1, 0
	move $t8, $t1
	b label_1021
label_1021:
	beqz $t8, label_1016
	b label_1015
label_1015:
	li $t1, 1
	move $t8, $t1
	b label_1017
label_1016:
	li $t1, 0
	move $t8, $t1
	b label_1017
label_1017:
	beqz $t8, label_1012
	b label_1011
label_1011:
	li $t1, 1
	move $t8, $t1
	b label_1013
label_1012:
	li $t1, 0
	move $t8, $t1
	b label_1013
label_1013:
	beqz $t8, label_1008
	b label_1007
label_1007:
	li $t1, 1
	move $t8, $t1
	b label_1009
label_1008:
	li $t1, 0
	move $t8, $t1
	b label_1009
label_1009:
	beqz $t8, label_1004
	b label_1003
label_1003:
	li $t1, 1
	move $t8, $t1
	b label_1005
label_1004:
	li $t1, 0
	move $t8, $t1
	b label_1005
label_1005:
	beqz $t8, label_1000
	b label_999
label_999:
	li $t1, 1
	move $t8, $t1
	b label_1001
label_1000:
	li $t1, 0
	move $t8, $t1
	b label_1001
label_1001:
	beqz $t8, label_996
	b label_995
label_995:
	li $t1, 1
	move $t8, $t1
	b label_997
label_996:
	li $t1, 0
	move $t8, $t1
	b label_997
label_997:
	beqz $t8, label_992
	b label_991
label_991:
	li $t1, 1
	move $t8, $t1
	b label_993
label_992:
	li $t1, 0
	move $t8, $t1
	b label_993
label_993:
	beqz $t8, label_988
	b label_987
label_987:
	li $t1, 1
	move $t8, $t1
	b label_989
label_988:
	li $t1, 0
	move $t8, $t1
	b label_989
label_989:
	beqz $t8, label_985
	b label_984
label_984:
	lw $t1, global_5
	move $t8, $t1
	addi $t1, $t8, 1
	sw $t1, global_5
	b label_985
label_985:
label_982:
	move $t9, $t9
	addi $t9, $t9, 1
	b label_980
label_983:
label_978:
	move $s1, $s1
	addi $s1, $s1, 1
	b label_976
label_979:
label_974:
	move $s2, $s2
	addi $s2, $s2, 1
	b label_972
label_975:
label_970:
	move $s4, $s4
	addi $s4, $s4, 1
	b label_968
label_971:
label_966:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_964
label_967:
label_962:
	move $s4, $s0
	addi $s0, $s4, 1
	b label_960
label_963:
	lw $a0, global_5
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	li $v0, 0
	b label_959
label_959:
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
