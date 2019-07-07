-----------------------------------------------------------------------------
--
-- 5 함수
-- 
-- 함수 정의는 이름, 매개변수 목록, 함수 몸체로 구성
-- 매개변수의 개수와 인자의 개수가 다르면 남은 인자는 버려지고, 모자라면 해당 매개변수는 nil이 된다.
--
function incCount ( n )
	n = n or 1		--> n이 없다면 1이 됨
	count = count + n
end
--
-----------------------------------------------------------------------------
--
-- 5.1 여러 값 반환
--
-- 루아는 함수에서 여러 값을 반환할 수 있다.
-- 대표적인 예가 string.find 함수로 시작위치와 끝위치의 인덱스 2개를 반환한다.
s, e = string.find("hello Lua users", "Lua")
print(s, e)		--> 7 9 (참고로 문자열 첫 글자의 인덱스는 1이다)
--
--
-- 예를 들어 아래와 같은 함수가 있다면
function foo0 () end
function foo1 () return "a" end
function foo2 () return "a", "b" end
--
-- 다중 할당에서 호출된 함수가 마지막 표현식이라면, 필요한 개수에 맞춰 결과가 생성된다.
x, y = foo2()			--> x="a", y="b"
x = foo2()				--> x="a", b는 버려진다
x, y, z = 10, foo2()	-->	x=10, y="a", z="b"
--
-- 함수가 반환하는 값이 없거나 필요한 수만큼 반환하지 않으면 모자란 자리에 nil이 만들어진다.
x, y = foo0()			--> x=nil, y=nil
x, y = foo1()			--> x="a", y=nil
x, y, z = foo2()		--> x="a", y="b", z=nil
--
-- 함수 호출이 목록의 끝에 있지 않으면 하나의 값만 결과로 처리된다.
x, y = foo2(), 20		--> x="a", y=20
x, y = foo0(), 20, 30	--> x=nil, y=20, 30은 버려짐
--
-- print 함수나, 테이블 생성자 등 나머지 경우에서도 마지막에 있는 경우를 제외하고는 1개만 반환된다.
-- 반환값을 하나만 받고싶을 경우에는 함수 호출을 ()로 감싸면 된다. (foo2())
-- 그렇기에 반환값을 ()로 감싸는 것을 주의해야 한다. return (f(x))처럼 쓰면 1개만 반환된다.
--
--
-- table.unpack 함수는 다중 반환을 해주는 특수함수이다.
-- 인자로 받은 배열의 원소를 인덱스 1의 원소부터 모두 다중 반환한다.
print(table.unpack{10, 20, 30})		--> 10 20 30
a, b = table.unpack{10, 20, 30}		--> a=10, b=20, 30은 버려짐
--
-- 함수 타입의 변수를 이용하여 아래처럼 구현할 수도 있다.
f = string.find
a = {"hello", "ll"}
print(f(table.unpack(a)))
--
-- 보통 unpack 함수는 순수 순열인 경우에만 제대로 동작하기에 
-- 특별히 범위를 제한해야 하는 경우 다음과 같이 명시적으로 길이를 지정해 줄 수 있다.
print(table.unpack({"Sun", "Mon", "Tue", "Wed"}, 2, 3))		--> Mon Tue
--
-----------------------------------------------------------------------------
--
-- 5.2 가변 인자 함수
--
-- 루아 함수는 가변 인자를 받을 수 있다. 즉 호출할 때마다 서로 다른 개수의 인자를 넣을 수 있다.
-- 함수가 가변 인자를 받게 하려면 매개변수 목록 자리에 점 세 개(...)를 쓰면 된다.
-- 함수에서 이 추가 인자를 가져오려면 점 세 개(...)를 표현식 자리에 다시 쓰면 된다.
--
-- 표현식 ...을 vararg 표현식이라고 하며 모든 추가 인자를 다중 반환하는 함수처럼 동작한다.
-- 예를 들어 다음 명령은 두 지역 변수를 가변 인자의 처음 2개의 값으로 초기화한다.
local a,b = ...
function id( ... ) return ... end
--
-- table.pack 함수는 임의의 개수의 인자를 받아서, 이 인자들을 모두 담고 있는 테이블을 생성해서 반환한다.
-- 여기서 만들어주는 테이블은 전체 인자 개수를 담고 있는 필드 "n"을 추가로 담고 있다.
-- 아래와 같이 원래 인자에 nil이 있었는지 알아내는 코드를 만들 수 있다.
function nonils( ... )
	local arg = table.pack(...)
	for i=1, arg.n do
		if arg[i] == nil then
			return false
		end
	end
	return true
end
--
-----------------------------------------------------------------------------
--
-- 5.3 이름 붙인 인자
--
-- 루아의 매개변수 전달 방식은 인자의 순서에 기반하고 있다.
-- 첫 번째 인자가 첫번째 매개변수에 전달, 두번째 인자가 두번쨰 매개변수에 전달, ...
--
-- 하지만 인자를 전달 받는 매개변수를 이름으로 지정하고 싶을 때
-- 이런 문법을 지원하지는 않지만, 구문을 약간 바꿔 같은 효과를 얻도록 할 수 있다.
--
-- 인자들을 모두 한 테이블로 묶고, 이 테이블 하나를 함수에 인자로 전달하는 것이다.
-- 루아에서 함수를 호출할 때 테이블 생성자 하나가 인자인 경우 괄호를 생략할 수 있다.
-- rename({old = "temp.lua", new = "temp1.lua"})
-- rename(old = "temp.lua", new = "temp1.lua")
--
-- 그렇기에 다음과 같이 매개변수가 하나만 있는 rename 함수를 정의해서 old, new 인자를 os.rename으로 전달한다
function rename( arg )
	return os.rename(arg.old, arg.new)
end
--
-----------------------------------------------------------------------------

-- 연습문제 5.1
-- 임의 개수의 문자열을 전달 받아서, 받은 문자열을 모두 이어 붙인 문자열을 반환하는 함수를 작성해보자.
function addstring( ... )
	local strings = table.pack(...)
	local newstring = ""
	for i=1, strings.n do
		newstring = newstring .. strings[i]
	end
	return newstring
end
print(addstring("hello ", "practice ", "5.1"))


-- 연습문제 5.2
-- 배열을 인자로 받아서 받은 배열의 모든 원소를 출력하는 함수를 작성하자.
-- 이때 table.unpack 함수를 써서 구현하는 방법의 장점과 단점을 고려해 보자.
function allprint( arr )
	print(table.unpack(arr))
end
allprint({"abc","def","gh","i"})


-- 연습문제 5.3
-- 임의 개수의 값을 인자로 받아서 첫 인자를 제외한 나머지 인자를 모두 반환하는 함수를 작성하자.
function exceptFirst( ... )
	local origin = table.pack(...)
	local result = {}

	-- 첫 인자를 제외하기 위해 2번부터 시작
	for i=2, origin.n do
		result[i-1] = origin[i]
	end
	
	return table.unpack(result)
end

print(exceptFirst("abc","def","gh","i"))