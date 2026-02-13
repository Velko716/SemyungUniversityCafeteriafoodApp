//
//  SkeletonView.swift
//  Components
//
//  Created by 김진혁 on 2/12/26.
//

import SwiftUI

public struct SkeletonView<S: Shape>: View {
    
    var shape: S
    var color: Color
    
    public init(
        _ shape: S,
        _ color: Color = .gray.opacity(0.6) // FIXME: - 컬러 수정
    ) {
        self.shape = shape
        self.color = color
    }
    
    @State private var isAnimation: Bool = false
    
    /// Customizable Properties
    var rotation: Double {
        return 5
    }
    
    var animation: Animation {
        .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    }
    
    
    public var body: some View {
        shape
            .fill(color)
        // Skeleton Effect
            .overlay {
                GeometryReader { // Shape 모양의 오버레이에 GeomeryReader가 있다는 것.
                    let size = $0.size
                    let skeletonWidth = size.width / 2
                    
                    let blurRadius = max(skeletonWidth / 1.5, 40)
                    let blurDiameter = blurRadius * 2
                    
                    let minX = -(skeletonWidth + blurDiameter)
                    let maxX = size.width + skeletonWidth + blurDiameter
                    
                    
                    Rectangle()
                    //            .fill(.gray)
                    //            .frame(width: skeletonWidth, height: size.height * 2)
                        .fill(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.6),
                                    .white.opacity(0.25),
                                    .white.opacity(0.6)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: skeletonWidth * 1.5, height: size.height * 2)
                        .frame(height: size.height)
                        .blur(radius: blurRadius)
                        .rotationEffect(.init(degrees: rotation)) // rotation(도 단위) 값만큼 사각형을 회전시킴 (애니메이션용)
                        .blendMode(.softLight) // softLight 블렌드 모드 적용 (밑 배경과 자연스럽게 섞임)
                        .offset(x: isAnimation ? maxX : minX) // isAnimation 값에 따라 왼쪽에서 오른쪽으로 이동시킴 (스켈레톤 애니메이션 효과)
                    
                }
            }
            .clipShape(shape)
            .compositingGroup()
            .task {
                guard !isAnimation else { return }
                withAnimation(animation) {
                    isAnimation = true
                }
            }
            .onDisappear {
                isAnimation = false
            }
            .transaction {
                if $0.animation != animation {
                    $0.animation = .none
                }
            }
    }
}

#Preview("원") {
    @Previewable
    @State var isTapped: Bool = false
    
    SkeletonView(.circle)
        .frame(width: 100, height: 100)
        .onTapGesture {
            withAnimation(.smooth) {
                isTapped.toggle()
            }
        }
        .padding(.bottom, isTapped ? 15 : 0)
}

#Preview("사각형") {
    @Previewable
    @State var isTapped: Bool = false
    
    SkeletonView(.rect)
        .frame(width: 100, height: 100)
        .onTapGesture {
            withAnimation(.smooth) {
                isTapped.toggle()
            }
        }
        .padding(.bottom, isTapped ? 15 : 0)
}

#Preview("캡슐") {
    @Previewable
    @State var isTapped: Bool = false
    
    SkeletonView(.capsule)
        .frame(width: 100, height: 100)
        .onTapGesture {
            withAnimation(.smooth) {
                isTapped.toggle()
            }
        }
        .padding(.bottom, isTapped ? 15 : 0)
}
