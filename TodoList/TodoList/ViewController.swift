import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var currentYPosition: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 텍스트 필드 스타일 설정
        configureTextInputField()
        
        // 버튼 스타일 설정
        configureMainButton()
    }
    
    private func configureTextInputField() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textInputField.frame.height))
        textInputField.leftView = paddingView
        textInputField.leftViewMode = .always
        textInputField.layer.cornerRadius = 20
        textInputField.layer.masksToBounds = true
        textInputField.layer.borderWidth = 1
        textInputField.layer.borderColor = UIColor.lightGray.cgColor
        let placeholderText = "Add a new todo..."
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.lightGray
        ]
        textInputField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    }
    
    private func configureMainButton() {
        mainButton.layer.cornerRadius = 15
        mainButton.layer.masksToBounds = true
    }
    
    @IBAction func mainButtonTapped(_ sender: UIButton) {
        guard let text = textInputField.text, !text.isEmpty else { return }
        
        // 텍스트 필드 비우기
        textInputField.text = ""
        
        // 새로운 레이블 생성 (PaddedLabel 사용)
        let newLabel = PaddedLabel()
        newLabel.text = text
        newLabel.font = UIFont.systemFont(ofSize: 23)
        newLabel.textColor = UIColor.black
        newLabel.numberOfLines = 0
        newLabel.backgroundColor = UIColor.white
        newLabel.layer.borderColor = UIColor.black.cgColor
        newLabel.layer.borderWidth = 1
        newLabel.layer.cornerRadius = 15
        newLabel.layer.masksToBounds = true
        
        // 레이블의 여백 설정
        newLabel.textInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)  // 왼쪽에 여백 추가
        
        // 레이블의 위치는 currentYPosition을 기준으로 설정
        newLabel.frame = CGRect(x: 0, y: currentYPosition, width: scrollView.frame.width - 8, height: 70)
        
        // 레이블을 스크롤뷰에 추가
        scrollView.addSubview(newLabel)
        
        // 레이블을 추가한 후 currentYPosition을 갱신
        currentYPosition += newLabel.frame.height + 10
        
        // 스크롤뷰의 contentSize 업데이트
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: currentYPosition)
        
        // 토글 버튼 만들기
        let toggleButton = UIButton(type: .custom)
        toggleButton.frame = CGRect(x: 10, y: (newLabel.frame.height - 30) / 2, width: 30, height: 30)
        toggleButton.layer.cornerRadius = 15  // 동그라미 모양
        toggleButton.layer.masksToBounds = true
        toggleButton.backgroundColor = .lightGray
        
        // isUserInteractionEnabled 설정하여 버튼 클릭이 가능하도록 함
        toggleButton.isUserInteractionEnabled = true
        
        // 이벤트 추가
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped(_:)), for: .touchUpInside)
        
        // 토글 버튼을 레이블 안에 추가
        newLabel.addSubview(toggleButton)
        
        // 레이블의 clipsToBounds를 false로 설정하여 버튼이 가려지지 않도록 함
        newLabel.clipsToBounds = false
        
        // 버튼을 레이블의 가장 위로 올리기
        newLabel.bringSubviewToFront(toggleButton)
        
        // 레이아웃 업데이트
        newLabel.setNeedsLayout()
        newLabel.layoutIfNeeded()
    }
    
    // 토글 버튼 클릭 시 동작
    @objc func toggleButtonTapped(_ sender: UIButton) {
        print("Button Tapped!") // 버튼 클릭 확인을 위한 로그 출력
        
        // 토글 버튼 색을 바꿔서 상태 변경
        sender.backgroundColor = sender.backgroundColor == .lightGray ? .green : .lightGray
    }
}
