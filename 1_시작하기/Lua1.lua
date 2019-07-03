-----------------------------------------------------------------------------
--
-- 1.1 청크
--
-- 순서대로 실행되는 명령이나 문장(코드 조각)
-- 세미콜론(;)을 쓰지 않아도 되며,
-- 줄바꿈은 아무런 역할도 하지않음.
--
-----------------------------------------------------------------------------
--
-- 1.2 어휘 규정
--
-- 루아의 식별자는 문자, 숫자, 언더바(_)로 구성된 문자열
-- 숫자로 시작할 수 없다.
-- 예약어들은 당연히 안됨. and는 예약어지만 And나 AND같이는 사용가능 
--
-- 하이픈 두개(--)로 시작하면 그 줄 끝까지 주석
-- --[[부터 ]]까지는 블록 주석
--
-----------------------------------------------------------------------------
--
-- 1.3 전역 변수
--
-- 그냥 쓰면 전역 변수임.
-- 초기화 안 하면 nil.
-- nil을 대입하면 변수를 초기화.(메모리 재활용)
--
-----------------------------------------------------------------------------
--
-- 1.4 독립 실행형 인터프리터
--
-- 첫 줄이 #으로 시작하면 그 줄은 무시
--
-----------------------------------------------------------------------------

-- 연습문제 1.1
-- 팩토리얼 예제 음수 문제 안생기게 수정
function fact( n )
	if n<0 then
		return 0
	elseif n==0 then
		return 1
	else
		return n * fact(n-1)
	end
end

print("enter a number:")
a = io.read("*n") -- 숫자로 입력받음
print(fact(a))

-----------------------------------------------------------------------------
--[[

io.read() 참고

s = io.read("*n") -- read a number
s = io.read("*l") -- read a line (default when no parameter is given)
s = io.read("*a") -- read the complete stdin
s = io.read(7) -- read 7 characters from stdin
x,y = io.read(7,12) -- read 7 and 12 characters from stdin and assign them to x and y
a,b = io.read("*n","*n") -- read two numbers and assign them to a and b

--]]
-----------------------------------------------------------------------------